defmodule UrlShortnerWeb.HomeControllerTest do
  use UrlShortnerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "URL Shortner"
  end
end
