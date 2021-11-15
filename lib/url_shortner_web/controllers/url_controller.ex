defmodule UrlShortnerWeb.UrlController do
  use UrlShortnerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", %{url: nil})
  end

  def create(conn, params) do
    UrlShortner.shorten_url(params)
    |> handle_response(conn)
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

  defp handle_response({:ok, url}, conn) do
    conn
    |> put_flash(:info, "Created with success")
    |> render("index.html", %{url: url})
  end

  defp handle_response({:error, _changeset}, conn) do
    conn
    |> put_flash(:error, "Oops, we couldn't shorten the URL, check it and try again.")
    |> render("index.html", %{url: nil})
  end
end
