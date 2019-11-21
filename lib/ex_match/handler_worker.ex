defmodule ExMatch.HandlerWorker do
  use GenServer

  @repeat_time 30_000 #30 seconds

  def start_link(init_mod) do
    GenServer.start_link(__MODULE__, init_mod, name: init_mod)
  end

  @impl true
  def init(init_mod) do
    state = init_mod.init()

    repeating_job()

    {:ok, state}
  end

  @impl true
  def handle_info(:get_match, {handler, opts} = state) do
    opts
    |> handler.process()
    |> handler.after_process()

    repeating_job()

    {:noreply, state}
  end

  defp repeating_job() do
    Process.send_after(self(), :get_match, @repeat_time)
  end

end
