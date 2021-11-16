defmodule UrlShortnerWeb.UrlController do
  alias UrlShortner.Repo
  use UrlShortnerWeb, :controller

  import Ecto.Query

  def index(conn, _params) do
    url_ids = get_session(conn, :urls)

    urls = Repo.all(from u in UrlShortner.Url, where: u.id in ^url_ids)

    render(conn, "index.html", %{urls: urls})
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

  defp handle_response({:ok, %UrlShortner.Url{id: id}}, conn) do
    ids = [id | get_session(conn, :urls)]

    conn
    |> put_session(:urls, ids)
    |> put_flash(:info, "Created with success")
    |> redirect(to: "/")
  end

  defp handle_response({:error, _changeset}, conn) do
    conn
    |> put_flash(:error, "Oops, we couldn't shorten the URL, check it and try again.")
    |> render("index.html", %{url: nil})
  end
end
