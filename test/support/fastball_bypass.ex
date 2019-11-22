defmodule FastBallBypass do

  defmacro __using__(_) do
    quote location: :keep do

      def setup_fastball_bypass(context) do
        bypass = Bypass.open(port: FastBallBypass.get_port())
        Bypass.expect(bypass, &handle_request(&1, context))
        %{bypass: bypass}
      end

      def handle_request(%{method: "GET"} = conn, %{resp_with: 503}) do
        Plug.Conn.resp(conn, 503, "")
      end

      def handle_request(%{method: "GET"} = conn, %{resp_with: 400}) do
        Plug.Conn.resp(conn, 400, "")
      end

      def handle_request(%{method: "GET", path_info: ["feed", "fastball"]} = conn, _context) do
        resp_body = %{
          "matches" => [
            %{
              "home_team" => "Manchester United",
              "away_team" => "Amkar FC",
              "kickoff_at" => "2019-12-19T09:00:00Z",
              "created_at" => 1543751200
            }
          ]
        } |> Jason.encode!

        Plug.Conn.resp(conn, 200, resp_body)
      end
    end
  end

  def get_port do
    Application.get_env(:ex_match, :providers)[:fastball][:base_url]
    |> String.split(":")
    |> List.last
    |> String.to_integer
  end
end
