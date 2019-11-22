defmodule ExMatch.Provider.Matchbeam do
  @behaviour ExMatch.Provider

  alias ExMatch.HTTPClient

  @config Application.get_env(:ex_match, :providers)[:matchbeam]
  @call_url "#{@config[:base_url]}/#{@config[:path]}"

  @impl true
  def init() do
    {__MODULE__, empty_state()}
  end

  @impl true
  def process(_) do
    case HTTPClient.call(@call_url) do
      {:ok, body} ->
        save(body["matches"])

        {__MODULE__, %{}}

      {:error, _} ->
        {__MODULE__, %{}}
    end
  end


# NOTICE
# In case we don't want the same matches occurred in our DB
# much better to cache already recorded matches to ETS
# and checked whenever they already persist or not.
# Now we relay on Ecto's unique_constraint checkings.
  def save(params) do
    for p <- params do
      p
      |> serialize()
      |> ExMatch.save_match
    end
  end

  defp empty_state do
    %{}
  end

  defp serialize(params) do
    params
    |> split_teams()
    |> set_provider()
  end

  defp split_teams(%{"teams" => teams} = params) do
    [home_team, away_team] = String.split(teams, " - ")

    Map.merge(params, %{
      "home_team" => home_team,
      "away_team" => away_team
    })
  end

  defp set_provider(params) do
    Map.put(params, "provider", "matchbeam")
  end

end
