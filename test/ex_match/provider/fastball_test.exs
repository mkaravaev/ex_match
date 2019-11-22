defmodule ExMatch.Provider.FastballTest do
  use ExMatch.DefaultCase
  use FastBallBypass

  import ExMatch.Factory, only: [insert_fastball_match: 1]

  alias ExMatch.TimeHelper
  alias ExMatch.Repo
  alias ExMatch.Match
  alias ExMatch.Provider.Fastball


  describe "&init/0" do
    setup [
      :insert_fastball_match,
    ]

    test "should return time of last record saved", %{fastball: fastball} do
      {mod, %{last_checked_at: unix_time}} = Fastball.init()

      assert mod == Fastball
      assert unix_time == TimeHelper.naive_to_unix(fastball.inserted_at) 
    end
  end

  describe "&process/1 success response" do
    setup [:setup_fastball_bypass]

    test "should successed without last_checked_at (firts call)" do
      {_mod, time_now} = Fastball.process(%{last_checked_at: nil})
      assert time_now.last_checked_at == TimeHelper.time_now_unix
      assert Repo.count(Match) == 1
    end

    test "should fetch and save matches from resource" do
      {_mod, time_now} = Fastball.process(%{last_checked_at: 131231})
      assert time_now.last_checked_at == TimeHelper.time_now_unix
      assert Repo.count(Match) == 1
    end
  end

  describe "&process/1 same match received" do
    setup [:setup_fastball_bypass]

    test "should fetch and save matches from resource" do
      Fastball.process(%{last_checked_at: 131231})
      Fastball.process(%{last_checked_at: 133000})
      assert Repo.count(Match) == 1
    end
  end

  describe "&process/1 temporarily unavailable" do
    setup [
      :set_resp_to_503,
      :setup_fastball_bypass
    ]

    test "should not save any data" do
      ExMatch.Provider.Fastball.process(%{last_checked_at: 131231})
      assert Repo.count(Match) == 0
    end
  end

  describe "&process/1 invalid query params" do
    setup [
      :set_resp_to_400,
      :setup_fastball_bypass
    ]

    test "should not save any data" do
      ExMatch.Provider.Fastball.process(%{last_checked_at: 131231})
      assert Repo.count(Match) == 0
    end
  end

  defp set_resp_to_503(_context), do: [resp_with: 503]
  defp set_resp_to_400(_context), do: [resp_with: 400]
end
