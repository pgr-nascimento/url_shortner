defmodule UrlShortner.Url do
  alias UrlShortner.Repo

  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query

  @url_regex ~r/^(http|https):\/\/(www.)?\w+\.[\w\/?=#%+&.-]+/

  schema "urls" do
    field :original_url, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original_url, :slug])
    |> validate_required([:original_url, :slug])
    |> validate_url()
    |> unique_constraint(:slug)
  end

  def by_ids(nil), do: []
  def by_ids([]), do: []

  def by_ids(ids) do
    Repo.all(from u in UrlShortner.Url, where: u.id in ^ids)
  end

  defp validate_url(changeset) do
    url = get_field(changeset, :original_url)

    if valid_url?(url) do
      changeset
    else
      add_error(changeset, :original_url, "is not valid")
    end
  end

  defp valid_url?(url) do
    url && String.match?(url, @url_regex)
  end
end
