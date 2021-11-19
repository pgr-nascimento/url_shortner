defmodule UrlShortnerWeb.UrlViewTest do
  use UrlShortner.DataCase, async: true

	doctest UrlShortnerWeb.UrlView
	alias UrlShortnerWeb.UrlView

  alias UrlShortner.{Repo, Url}

  describe "build_link/2" do
    test "It should builds the shorten link" do
      slug = "xkcd327"
      Repo.insert(%Url{original_url: "https://google.com", slug: slug})

      result = UrlView.build_link(UrlShortnerWeb.Endpoint, slug)

      assert result == "/#{slug}"
    end
  end

  describe "build_link_text/1" do
    test "it should returns the entire url shortned to show to the user" do
      slug = "xkcd327"
      Repo.insert(%Url{original_url: "https://google.com", slug: slug})

      result = UrlView.build_link_text(slug)

      assert result == "localhost/#{slug}"
    end
  end
end
