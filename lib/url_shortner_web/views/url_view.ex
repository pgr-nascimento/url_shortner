defmodule UrlShortnerWeb.UrlView do
  use UrlShortnerWeb, :view

  @doc """
  This fn returns the host + the slug of the URL to show to the user the URL shortned
  """
  def build_link_text(slug) do
    "#{UrlShortnerWeb.Endpoint.url()}/#{slug}"
  end
end
