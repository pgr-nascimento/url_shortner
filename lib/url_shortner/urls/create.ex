defmodule UrlShortner.Urls.Create do
  alias UrlShortner.{Url, Repo, SlugGenerator}

  def call(params, slug_function \\ &SlugGenerator.generate/0) do
    random_slug(slug_function)
    |> Map.merge(params)
    |> url_changeset
    |> insert_url
  end

  defp random_slug(slug_function) do
    %{"slug" => slug_function.()}
  end

  defp url_changeset(params) do
    Url.changeset(%Url{}, params)
  end

  defp insert_url(changeset) do
    Repo.insert(changeset)
  end
end
