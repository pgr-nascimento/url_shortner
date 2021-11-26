defmodule UrlShortnerWeb.UrlControllerTest do
  @moduledoc false

  use UrlShortnerWeb.ConnCase

  alias UrlShortner.{Repo, Url}

  import Ecto.Query

  test "without URLs created by the user, do not see others URLs" do
    {:ok, %{id: first_id}} = Repo.insert(%Url{original_url: "https://xkcd.com", slug: "xkcd327"})
    Repo.insert(%Url{original_url: "https://google.com", slug: "ggle308"})

    response =
      session_conn()
      |> put_session(:urls, [first_id])
      |> get("/")
      |> html_response(:ok)

    assert response =~ "https://xkcd.com"
    assert response =~ "xkcd327"
    refute response =~ "https://google.com"
    refute response =~ "ggle308"
  end

  test "See a list with all urls created by the user" do
    {:ok, %{id: first_id}} = Repo.insert(%Url{original_url: "https://xkcd.com", slug: "xkcd327"})

    {:ok, %{id: second_id}} =
      Repo.insert(%Url{original_url: "https://google.com", slug: "ggle308"})

    response =
      session_conn()
      |> put_session(:urls, [first_id, second_id])
      |> get("/")
      |> html_response(:ok)

    assert response =~ "https://xkcd.com"
    assert response =~ "xkcd327"
    assert response =~ "https://xkcd.com"
    assert response =~ "ggle308"
  end

  test "Save the URL with an shorten link", %{conn: conn} do
    original_url = "http://www.google.com.br"

    conn = post(conn, Routes.url_path(conn, :create), %{original_url: original_url})

    assert %Url{slug: _slug, original_url: ^original_url} =
             Repo.one(from url in Url, order_by: [desc: url.id], limit: 1)

    assert redirected_to(conn) == "/"
  end

  test "Redirect to the original URL", %{conn: conn} do
    slug = "xkcd327"
    Repo.insert(%Url{original_url: "https://google.com", slug: slug})

    conn = get(conn, Routes.url_path(conn, :show, slug))

    assert redirected_to(conn) == "https://google.com"
  end

  test "when the shorten url is not found, it renders to not found template", %{conn: conn} do
    slug = "xkcd327"

    response =
      conn
      |> get(Routes.url_path(conn, :show, slug))
      |> html_response(:not_found)

    expected_response = "Sorry, we can't find the original URL."

    assert String.contains?(response, expected_response)
  end
end
