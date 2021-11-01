defmodule UrlShortner.UrlTest do
  use UrlShortner.DataCase, async: true

  alias UrlShortner.Url
  alias UrlShortner.Repo

  describe "insert url" do
    test "when all params are valid, returns a created Url" do
      params = %{original_url: "www.google.com.br", slug: "xkcd137"}
      changeset = Url.changeset(%Url{}, params)

      {:ok, %Url{id: url_id}} = Repo.insert(changeset)
      url = Repo.get(Url, url_id)

      assert %Url{id: ^url_id, original_url: "www.google.com.br", slug: "xkcd137"} = url
    end

    test "when the original_url is empty, returns an error" do
      params = %{original_url: "", slug: "xkcd137"}

      expected_response = %{
        original_url: ["can't be blank"]
      }

      changeset = Url.changeset(%Url{}, params)

      {:error, response} = Repo.insert(changeset)

      assert expected_response == errors_on(response)
    end

    test "when the slugh already exists, returns an error" do
      params = %{original_url: "www.google.com", slug: "xkcd137"}

      expected_response = %{
        slug: ["has already been taken"]
      }

      changeset = Url.changeset(%Url{}, params)
      Repo.insert(changeset)

      {:error, response} = Repo.insert(changeset)

      assert expected_response == errors_on(response)
    end
  end
end
