defmodule ExMatch.Provider.Fastball do
  @behaviour ExMatch.Provider

  alias ExMatch.HTTPClient
  alias ExMatch.TimeHelper

  @config Application.get_env(:ex_match, :providers)[:fastball]
  @url "#{@config[:base_url]}/#{@config[:path]}"

  @impl true
  def init() do
    {__MODULE__, %{last_checked_at: get_last_checked_at()}}
  end

  @impl true
  def process(%{last_checked_at: checked_time} = params) do
    case HTTPClient.call(@url, params) do
      {:ok, body} ->
        time_now = time_now()
        save(body)

        {__MODULE__, %{last_checked_at: time_now}}

      {:error, _} ->
        {__MODULE__, %{last_checked_at: checked_time}}
    end
  end

  @impl true
  def after_process(_) do
  end

  def save(params) do
    for p <- params do
      p
      |> Map.put("provider", "fastball")
      |> ExMatch.save
    end
  end

  defp get_last_checked_at do
    ExMatch.get_last_checked_at(provider: "fastball")
  end

  defp time_now, do: TimeHelper.time_now_unix
end
