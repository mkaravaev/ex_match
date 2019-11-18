defmodule ExMatch.Fastball do
  @behaviour ExMatch.MatchHandler

  @impl ExMatch.MatchHandler
  def init() do
    %{last_checked_at: get_last_checked_at()}
  end

  @impl ExMatch.MatchHandler
  def process(_) do
  end

  @impl ExMatch.MatchHandler
  def after_process(_) do
  end

  defp get_last_checked_at do
    :ok
  end

  defp call do
    :ok
    #here will be settings for HTTPoison call
  end
end
