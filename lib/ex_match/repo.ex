defmodule ExMatch.Repo do
  use Ecto.Repo,
    otp_app: :ex_match,
    adapter: Ecto.Adapters.Postgres
end
