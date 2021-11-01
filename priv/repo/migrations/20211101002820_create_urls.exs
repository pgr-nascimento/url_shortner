defmodule UrlShortner.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_url, :string
      add :slug, :string

      timestamps()
    end
  end
end
