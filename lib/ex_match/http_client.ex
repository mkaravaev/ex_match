defmodule ExMatch.HTTPClient do
  @moduledoc false

  def call(url, params) do
    params
    |> remove_nil_params()
    |> do_call(url)
    |> case do
         {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
           {:ok, Jason.decode!(body)}

         {:ok, %HTTPoison.Response{status_code: 400}} ->
           {:error, :invalid_params}

         {:ok, %HTTPoison.Response{status_code: 503}} ->
           {:error, :temporarily_unavailable}
       end
  end

  def remove_nil_params(params) do
    Enum.reject(params, fn{_key, val} -> is_nil(val) end)
  end

  defp do_call([], url), do: HTTPoison.get(url)
  defp do_call(params, url), do: HTTPoison.get(url, [], params: params)

end
