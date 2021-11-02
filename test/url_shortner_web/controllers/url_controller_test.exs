defmodule UrlShortnerWeb.UrlControllerTest do
  @moduledoc false

  use UrlShortnerWeb.ConnCase

  alias UrlShortner.{Repo, Url}

  import Ecto.Query

  test "Save the URL with an shorten link", %{conn: conn} do
    conn = post(conn, Routes.url_path(conn, :create), %{original_url: "http://www.google.com.br"})

    %Url{slug: slug} = Repo.one(from url in Url, order_by: [desc: url.id], limit: 1)

    assert html_response(conn, 200) =~ "localhost:4000/#{slug}"
  end

  test "Redirect to the original URL", %{conn: conn} do
    slug = "xkcd327"
    Repo.insert(%Url{original_url: "https://google.com", slug: slug})

    conn = get(conn, Routes.url_path(conn, :show, slug))

    assert redirected_to(conn) == "https://google.com"
  end
end
