defmodule UrlShortner.Repo.Migrations.AddUniqueIndexToSlug do
  use Ecto.Migration

  def change do
    create unique_index(:urls, [:slug])
  end
end
