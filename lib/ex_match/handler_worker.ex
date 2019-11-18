defmodule ExMatch.HandlerWorker do
  use GenServer

  @repeat_time 30 #seconds

  def start_link(init) do
    GenServer.start_link(__MODULE__, init)
  end

  @impl true
  def init(mod) do
    state = mod.init()

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
