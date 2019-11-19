defmodule ExMatch do
  @moduledoc """
  Documentation for ExMatch.
  """

  alias ExMatch.Match
  alias ExMatch.Repo

  def get_last_checked_at(_), do: 123213123

  def save(params) do
    %Match{}
    |> Match.changeset(params)
    |> Repo.insert
  end
end
