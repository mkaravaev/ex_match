defmodule ExMatch.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :home_team, :string
    field :away_team, :string
    field :kickoff_at, :utc_datetime
    field :provider, :string
    field :created_at, :integer

    timestamps()
  end

  @allowed_fields ~w(home_team away_team kickoff_at created_at provider)a
  @required_fields @allowed_fields

  def changeset(struct, params) do
    struct
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:home_team, name: :matches_home_team_away_team_kickoff_at_index)
  end

end
