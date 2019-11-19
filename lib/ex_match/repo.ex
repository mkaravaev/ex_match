defmodule ExMatch.Repo do
  use Ecto.Repo,
    otp_app: :ex_match,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query

  def count(module) do
    __MODULE__.aggregate(module, :count, :id)
  end

  def last(module) do
    __MODULE__.one(from x in module, order_by: [desc: x.inserted_at], limit: 1)
  end
end
