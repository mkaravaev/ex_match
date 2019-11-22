defmodule ExMatch.HandlerWorkerTest do
  use ExMatch.DefaultCase

  use MatchBeamBypass
  use FastBallBypass

  alias ExMatch.Provider.Matchbeam
  alias ExMatch.Provider.Fastball
  alias ExMatch.Match

  @worker_module ExMatch.HandlerWorker
  @init_childrens [Matchbeam, Fastball]

  setup [
    :setup_fastball_bypass,
    :setup_matchbeam_bypass,
    :start_workers
  ]

  describe "matchbeam provider" do
    test "handlers should grap matches from resource", %{
            ExMatch.Provider.Fastball => fastball_pid,
            ExMatch.Provider.Matchbeam => matchbeam_pid
         } do

      assert Repo.count(Match) == 0

      ExMatch.HandlerWorker.make_call_now(fastball_pid)
      assert Repo.count(Match) == 1

      ExMatch.HandlerWorker.make_call_now(matchbeam_pid)
      assert Repo.count(Match) == 2

    end
  end

  defp start_workers(_context) do
    Enum.map(@init_childrens, fn ch ->
      {:ok, pid} = start_supervised(
        Supervisor.child_spec({@worker_module, ch}, id: ch)
      )
      {ch, pid}
    end)
  end

end
