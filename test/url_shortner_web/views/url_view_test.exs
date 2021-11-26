defmodule UrlShortnerWeb.UrlViewTest do
  use UrlShortner.DataCase, async: true

  doctest UrlShortnerWeb.UrlView
  alias UrlShortnerWeb.UrlView

  describe "build_link_text/1" do
    test "it should returns the entire url shortned to show to the user" do
      slug = "xkcd327"

      result = UrlView.build_link_text(slug)

      assert result == "http://localhost:4000/#{slug}"
    end
  end

  describe "format_original_url/1" do
    test "when the url is big than our reference value, it should short it and put ellipsis" do
      url = "https://www.google.com/search?q=busca+de+uma+url+bem+grande+no+g"

      result = UrlView.format_original_url(url)

      assert result == "https://www.google.com/search?q=busca+de+uma+url+bem+gra..."
    end

    test "when the url is shorter than our reference value, it should return the full url without ellipsis" do
      url = "https://www.google.com/"

      result = UrlView.format_original_url(url)

      assert result == "https://www.google.com/"
    end
  end
end
