defmodule UrlShortner.Url do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> unique_constraint(:slug)
  end
end
