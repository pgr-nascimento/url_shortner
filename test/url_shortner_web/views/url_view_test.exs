defmodule UrlShortnerWeb.UrlViewTest do
  use UrlShortner.DataCase, async: true

  doctest UrlShortnerWeb.UrlView
  alias UrlShortnerWeb.UrlView

  alias UrlShortner.{Repo, Url}

  describe "build_link_text/1" do
    test "it should returns the entire url shortned to show to the user" do
      slug = "xkcd327"
      Repo.insert(%Url{original_url: "https://google.com", slug: slug})

      result = UrlView.build_link_text(slug)

      assert result == "http://localhost:4000/#{slug}"
    end
  end
end
