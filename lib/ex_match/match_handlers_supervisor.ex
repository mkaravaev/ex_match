defmodule ExMatch.MatchHandlersSupervisor do
  use Supervisor

  @worker_module ExMatch.HandlerWorker

  def start_link(init) do
    Supervisor.start_link(__MODULE__, init, name: __MODULE__)
  end

  def init(init_children) do
    children =
      Enum.map(init_children, &(
        Supervisor.child_spec({@worker_module, &1}, id: &1)
      ))

    Supervisor.init(children, strategy: :one_for_one)
  end

end
