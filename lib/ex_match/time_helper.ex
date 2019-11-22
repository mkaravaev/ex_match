defmodule ExMatch.TimeHelper do
  def time_now_unix, do: DateTime.utc_now |> DateTime.to_unix

  def naive_to_unix(naive_datetime, timezone \\ "Etc/UTC") do
    {:ok, date_time} = DateTime.from_naive(naive_datetime, timezone) 
    DateTime.to_unix(date_time)
  end
end
