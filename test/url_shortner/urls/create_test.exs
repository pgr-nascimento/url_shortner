defmodule UrlShortner.Urls.CreateTest do
  @moduledoc false
  use UrlShortner.DataCase, async: true

  alias UrlShortner.Urls.Create, as: UrlCreator
  alias UrlShortner.{Repo, Url}

  describe "call/2" do
    test "with valid params, create a new Url" do
      params = %{"original_url" => "https://www.google.com"}

      assert {:ok, url} = UrlCreator.call(params)
      assert %Url{id: _, original_url: "https://www.google.com", slug: slug} = url
      assert slug =~ ~r/\w{6}/
    end

    test "with invalid params, it returns an erro" do
      params = %{"original_url" => "www.google.com"}
      expected_error = %{original_url: ["is not valid"]}

      assert {:error, url} = UrlCreator.call(params)
      assert expected_error == errors_on(url)
    end

    test "when already exists the same slug on database, it returns an error" do
      Repo.insert(%Url{original_url: "https://www.google.com", slug: "xkcd327"})

      params = %{"original_url" => "https://www.google.com"}
      slug_fn = fn -> "xkcd327" end

      expected_error = %{
        slug: ["has already been taken"]
      }

      assert {:error, url} = UrlCreator.call(params, slug_fn)
      assert expected_error == errors_on(url)
    end
  end
end
