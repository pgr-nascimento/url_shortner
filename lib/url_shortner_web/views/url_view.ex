defmodule UrlShortnerWeb.UrlView do
  use UrlShortnerWeb, :view

  @doc """
  This fn returns the host + the slug of the URL to show to the user the URL shortned
  """
  def build_link_text(slug) do
    host = Application.get_env(:url_shortner, UrlShortnerWeb.Endpoint)[:url][:host]
    "#{host}/#{slug}"
  end
end
