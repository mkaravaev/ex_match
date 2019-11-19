use Mix.Config

config :ex_match, :providers,
  fastball: [
    base_url:  "http://forzaassignment.forzafootball.com:8080",
    path: "feed/fastball"
  ],
  matchbeam: [
    base_url: "http://forzaassignment.forzafootball.com:8080",
    path: "feed/matchbeam"
  ]
