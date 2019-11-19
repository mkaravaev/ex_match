defmodule ExMatch.Provider.Matchbeam do
  @behaviour ExMatch.Provider

  @impl true
  def init() do
    {__MODULE__, %{}}
  end

  @impl true
  def process(_) do
  end

  @impl true
  def after_process(_) do
  end

  def call do
    :ok
  end
end
