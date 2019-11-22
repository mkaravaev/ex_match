defmodule ExMatch.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    # NOTICE you should install citext extension first
    # If line below is not working do it by hand throught psql.
    #
    # execute "CREATE EXTENSION IF NOT EXISTS citext"

    create table(:matches) do
      add :home_team, :citext
      add :away_team, :citext
      add :kickoff_at, :utc_datetime
      add :provider, :string
      add :created_at, :integer

      timestamps()
    end

    create unique_index(:matches, [:home_team, :away_team, :kickoff_at])

  end
end
