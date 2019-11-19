defmodule ExMatch.HTTPClient do
  @moduledoc false

  def call(url, params) do
    case HTTPoison.get(url, [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, :invalid_params}

      {:ok, %HTTPoison.Response{status_code: 503}} ->
        {:error, :temporarily_unavailable}
    end
  end

end
