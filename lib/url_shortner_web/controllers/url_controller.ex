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

  def show(conn, %{"slug" => slug}) do
    url = UrlShortner.Repo.get_by(UrlShortner.Url, slug: slug)

    if url do
      redirect(conn, external: url.original_url)
    else
      conn
      |> put_status(:not_found)
      |> put_view(UrlShortnerWeb.ErrorView)
      |> render("404.html")
    end
  end
end
