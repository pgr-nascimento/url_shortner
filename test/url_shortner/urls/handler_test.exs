defmodule UrlShortner.Urls.HandlerTest do
  @moduledoc false

  use UrlShortner.DataCase, async: true

  alias UrlShortner.Urls.Handler, as: UrlHandler
  alias UrlShortner.Url

  describe "create/1" do
    test "with valid params, returns a tuple with a new Url" do
      params = %{"original_url" => "https://www.google.com"}

      assert {:ok, %Url{}} = UrlHandler.create(params)
    end

    test "with invalid params, it returns an error" do
      params = %{"original_url" => "www.google.com"}
      expected_error = %{original_url: ["is not valid"]}

      assert {:error, url} = UrlHandler.create(params)
      assert expected_error == errors_on(url)
    end
  end
end
