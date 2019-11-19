defmodule ExMatch.Fastball do
  @behaviour ExMatch.MatchHandler

  @config Application.get_env(:ex_match, :providers)[:fastball]

  @impl ExMatch.MatchHandler
  def init() do
    {__MODULE__, %{last_checked_at: get_last_checked_at()}}
  end

  @impl ExMatch.MatchHandler
  def process(%{last_checked_at: last_checked_at}) do
    last_checked_at
    |> call()
    # |> Jason.decode!
    # |> ExMatch.save!

    {__MODULE__, %{last_checked_at: time_now()}}
  end

  @impl ExMatch.MatchHandler
  def after_process(_) do
  end

  defp get_last_checked_at do
    ExMatch.get_last_checked_at(provider: "fastball")
  end

  defp call(last_checked_at) do
    HTTPoison.get!(@config[:base_url], [], params: %{last_checked_at: last_checked_at})
  end

  defp time_now, do: DateTime.utc_now |> DateTime.to_unix
end
