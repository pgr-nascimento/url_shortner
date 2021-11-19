defmodule UrlShortnerWeb.UrlView do
  use UrlShortnerWeb, :view

  def build_link(conn, slug) do
    Routes.url_path(conn, :show, slug)
  end

  def build_link_text(slug) do
    host = Application.get_env(:url_shortner, UrlShortnerWeb.Endpoint)[:url][:host]
    "#{host}/#{slug}"
  end
end
