defmodule ExMatch.Application do
  @moduledoc false

  use Application

  alias ExMatch.Provider.{Matchbeam, Fastball}

  def start(_type, _args) do
    children = [
      {ExMatch.Repo, []},
      {ExMatch.MatchHandlersSupervisor, [Matchbeam, Fastball]}
    ]

    opts = [strategy: :one_for_one, name: ExMatch.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
