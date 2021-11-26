defmodule UrlShortnerWeb.UrlView do
  use UrlShortnerWeb, :view

  @one_line_string 56

  @doc """
  This fn returns the host + the slug of the URL to show to the user the URL shortned
  """
  def build_link_text(slug) do
    "#{UrlShortnerWeb.Endpoint.url()}/#{slug}"
  end

  @doc """
  This fn check the lenght of the URL, if the URL is greather than @one_line_string it short to fit better on the screen
  """
  def format_original_url(url) do
    splitted_url = String.graphemes(url)

    if Enum.count(splitted_url) > @one_line_string do
      "#{Enum.take(splitted_url, @one_line_string)}..."
    else
      url
    end
  end
end
