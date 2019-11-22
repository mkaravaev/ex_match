defmodule ExMatch.Provider.MatchbeamTest do
  use ExMatch.DefaultCase
  use MatchBeamBypass

  alias ExMatch.Repo
  alias ExMatch.Match
  alias ExMatch.Provider.Matchbeam

  describe "&init/0" do
    test "should return time of last record saved" do
      assert {Matchbeam, %{}} = Matchbeam.init()
    end
  end

  describe "&process/1 success response" do
    setup [:setup_matchbeam_bypass]

    test "should fetch and save matches from resource" do
      Matchbeam.process(%{})
      assert Repo.count(Match) == 1
      assert Repo.last(Match).provider == "matchbeam"
    end

    test "should not save same match" do
      assert Repo.count(Match) == 0
      Matchbeam.process(%{})
      assert Repo.count(Match) == 1
      Matchbeam.process(%{})
      assert Repo.count(Match) == 1
    end
  end
end
