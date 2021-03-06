defmodule UrlShortner do
  @moduledoc """
  UrlShortner keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias UrlShortner.Urls.Handler, as: UrlHandler

  defdelegate shorten_url(params), to: UrlHandler, as: :create
end
