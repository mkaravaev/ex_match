defmodule ExMatch.TimeHelper do
  def time_now_unix, do: DateTime.utc_now |> DateTime.to_unix
end
