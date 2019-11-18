defmodule ExMatch.HandlerWorker do
  use GenServer

  def start_link(init) do
    GenServer.start_link(__MODULE__, init)
  end

  @impl true
  def init(mod) do
    state = mod.init()
    recurent_job()
    {:ok, state}
  end

  @impl true
  def handle_info(:get_match, handler) do
    # handler.process()
    # |> handler.after_process()

    recurent_job()

    {:noreply, handler}
  end

  defp recurent_job() do
    Process.send_after(self(), :get_match, 36000)
  end

end
