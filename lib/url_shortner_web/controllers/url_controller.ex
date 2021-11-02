defmodule UrlShortnerWeb.UrlController do
  use UrlShortnerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", %{url: nil})
  end

  def create(conn, params) do
    {:ok, url} = UrlShortner.shorten_url(params)

    conn
    |> put_flash(:info, "Created with sucess")
    |> render("index.html", %{url: url})
  end
end
