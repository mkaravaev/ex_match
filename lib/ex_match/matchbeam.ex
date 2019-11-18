defmodule ExMatch.Matchbeam do
  @behaviour ExMatch.MatchHandler

  @impl ExMatch.MatchHandler
  def init() do
    :ok
  end

  @impl ExMatch.MatchHandler
  def process(_) do
  end

  @impl ExMatch.MatchHandler
  def after_process(_) do
  end

  def call do
    :ok
  end
end
