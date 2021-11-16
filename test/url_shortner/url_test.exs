defmodule UrlShortner.UrlTest do
  use UrlShortner.DataCase, async: true

  alias UrlShortner.Url
  alias UrlShortner.Repo

  describe "insert url" do
    test "when all params are valid, returns a created Url" do
      params = %{original_url: "http://www.google.com.br", slug: "xkcd137"}
      changeset = Url.changeset(%Url{}, params)

      {:ok, %Url{id: url_id}} = Repo.insert(changeset)
      url = Repo.get(Url, url_id)

      assert %Url{id: ^url_id, original_url: "http://www.google.com.br", slug: "xkcd137"} = url
    end

    test "when the original_url is empty, returns an error" do
      params = %{original_url: "", slug: "xkcd137"}

      expected_response = %{
        original_url: ["is not valid", "can't be blank"]
      }

      changeset = Url.changeset(%Url{}, params)

      {:error, response} = Repo.insert(changeset)

      assert expected_response == errors_on(response)
    end

    test "when the original_url is invalid, returns an error" do
      params = %{original_url: "www.google.com", slug: "xkcd137"}

      expected_response = %{
        original_url: ["is not valid"]
      }

      changeset = Url.changeset(%Url{}, params)

      {:error, response} = Repo.insert(changeset)

      assert expected_response == errors_on(response)
    end

    test "when the slug already exists, returns an error" do
      params = %{original_url: "http://www.google.com", slug: "xkcd137"}

      expected_response = %{
        slug: ["has already been taken"]
      }

      changeset = Url.changeset(%Url{}, params)
      Repo.insert(changeset)

      {:error, response} = Repo.insert(changeset)

      assert expected_response == errors_on(response)
    end
  end

  describe "by_ids/1" do
    test "when the arg is an integer list, returns the Urls founded by the ids" do
      %Url{id: id} = Repo.insert!(%Url{original_url: "www.google.com", slug: "xkcd137"})
      %Url{id: second_id} = Repo.insert!(%Url{original_url: "www.xkcd.com", slug: "gKas123"})
      %Url{id: third_id} = Repo.insert!(%Url{original_url: "www.google.com", slug: "KJax129"})

      assert [%Url{id: ^id}, %Url{id: ^second_id}, %Url{id: ^third_id}] =
               Url.by_ids([id, second_id, third_id])
    end

    test "when the arg is nil, returns an empty list" do
      ids = nil

      assert Url.by_ids(ids) == []
    end

    test "when the args is an empty list, returns an empty list" do
      ids = []

      assert Url.by_ids(ids) == []
    end
  end
end
