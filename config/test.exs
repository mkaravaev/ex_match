use Mix.Config

config :ex_match, :providers,
  fastball: [
    base_url:  "http://localhost:4080",
    path: "feed/fastball"
  ],
  matchbeam: [
    base_url:  "http://localhost:4082",
    path: "feed/matchbeam"
  ]

config :ex_match, ExMatch.Repo,
  database: "ex_match_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

