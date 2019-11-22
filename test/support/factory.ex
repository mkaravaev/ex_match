defmodule ExMatch.Factory do
  alias ExMatch.Match

  def insert_fastball_match(context) do
    params = %{
      "home_team" => "Arsenal",
      "away_team" => "Chelsea FC",
      "kickoff_at" => "2018-12-19T09:00:00Z",
      "created_at" => 1543741200,
      "provider" => "fastball"
    }

    {:ok, match} = ExMatch.save_match(params)

    [fastball: match]
  end

  def insert_matchbeam_match(context) do
    params = %{
      "teams" => "Arsenal - Chelsea FC",
      "kickoff_at" => "2018-12-19T09:00:00Z",
      "created_at" => 1543741200,
      "provider" => "matchbeam"
    }

    {:ok, match} = ExMatch.save_match(params)

    [matchbeam: match]
  end

end
