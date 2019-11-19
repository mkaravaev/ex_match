defmodule ExMatch.Provider.FastballTest do
  use ExMatch.DefaultCase
  use FastBallBypass

  alias ExMatch.TimeHelper
  alias ExMatch.Repo
  alias ExMatch.Match

  @moduletag :focus

  describe "&process/1 success response" do
    setup [:setup_bypass]

    test "should fetch and save match from resource" do
      {_mod, time_now} = ExMatch.Provider.Fastball.process(%{last_checked_at: 131231})
      assert time_now.last_checked_at == TimeHelper.time_now_unix
      assert Repo.count(Match) == 1
    end
  end

  describe "&process/1 temporarily unavailable" do
    setup [
      :set_resp_to_503,
      :setup_bypass
    ]

    test "should not save any data" do
      ExMatch.Provider.Fastball.process(%{last_checked_at: 131231})
    end
  end

  describe "&process/1 invalid query params" do
    setup [
      :set_resp_to_400,
      :setup_bypass
    ]

    test "should not save any data" do
      ExMatch.Provider.Fastball.process(%{last_checked_at: 131231})
    end
  end

  defp set_resp_to_503(_context), do: [resp_with: 503]
  defp set_resp_to_400(_context), do: [resp_with: 400]
end
