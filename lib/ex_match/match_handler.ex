defmodule ExMatch.MatchHandler do
  @callback init() :: :ok
  @callback process(any) :: :ok
  @callback after_process(any) :: :ok
end
