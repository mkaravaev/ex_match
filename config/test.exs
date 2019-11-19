use Mix.Config

config :ex_match, :providers,
  fastball: [
    base_url:  "http://localhost:4080",
    path: "/feed/fastball"
  ],
  matchbeam: [
    base_url:  "http://localhost:4080",
    path: "/feed/matchbeam"
  ]

