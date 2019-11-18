defmodule ExMatch.MatchHandler do
  @callback init() :: {module(), Map.t()}
  @callback process(any) :: :ok
  @callback after_process(any) :: :ok
end
