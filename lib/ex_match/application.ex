defmodule ExMatch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias ExMatch.Provider.{Matchbeam, Fastball}

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      ExMatch.Repo,
      Supervisor.child_spec({ExMatch.HandlerWorker, Matchbeam}, id: :worker_1),
      Supervisor.child_spec({ExMatch.HandlerWorker, Fastball}, id: :worker_2)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExMatch.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
