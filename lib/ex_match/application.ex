defmodule ExMatch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Supervisor.child_spec({ExMatch.HandlerWorker, ExMatch.Matchbeam}, id: ExMatch.Matchbeam),
      Supervisor.child_spec({ExMatch.HandlerWorker, ExMatch.Fastball}, id: ExMatch.Fastball)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExMatch.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
