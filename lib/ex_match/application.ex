defmodule ExMatch.Application do
  @moduledoc false

  use Application

  alias ExMatch.Provider.{Matchbeam, Fastball}

  def start(_type, _args) do
    children = [
      {ExMatch.Repo, []},
    ]

    children =
      if Mix.env == :test do
        children
      else
        children ++ [{ExMatch.MatchHandlersSupervisor, [Matchbeam, Fastball]}]
      end

    opts = [strategy: :one_for_one, name: ExMatch.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
