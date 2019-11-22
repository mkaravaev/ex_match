defmodule ExMatch.HandlerWorker do
  use GenServer

  @repeat_time 30_000 #30 seconds

  #CLIENT#
  def start_link(init_mod) do
    GenServer.start_link(__MODULE__, init_mod, name: init_mod)
  end

  def make_call_now(pid) do
    GenServer.call(pid, :get_matches)
  end

  defp make_scheduled_call(time_out \\ @repeat_time) do
    Process.send_after(self(), :get_matches, time_out)
  end

  defp process({handler, opts}) do
    handler.process(opts)
  end

  #SERVER#
  @impl true
  def init(init_mod) do
    state = init_mod.init()

    unless evironment_is?(:test) do
      make_scheduled_call(1)
    end

    {:ok, state}
  end

  @impl true
  def handle_call(:get_matches, _from, state) do
    {:reply, :ok, process(state)}
  end

  @impl true
  def handle_info(:get_matches, state) do
    process(state)

    unless evironment_is?(:test) do
      make_scheduled_call()
    end

    {:noreply, state}
  end

  defp evironment_is?(env) do
    Application.get_env(:ex_match, :environment) == env
  end

end
