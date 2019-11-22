defmodule ExMatch do
  @moduledoc """
  Documentation for ExMatch.
  """

  import Ecto.Query

  alias ExMatch.Match
  alias ExMatch.Repo

  def get_last_match_for(provider: provider) do
    query = 
      from m in Match,
      where: m.provider == ^provider

    Repo.last(query)
  end

  def save_match(params) do
    %Match{}
    |> Match.changeset(params)
    |> Repo.insert
  end
end
