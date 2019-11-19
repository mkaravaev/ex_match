defmodule FastBallBypass do

  defmacro __using__(_) do
    quote location: :keep do

      def setup_bypass(context) do
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

      def handle_request(%{method: "GET"} = conn, _context) do
        resp_body = [
          %{
            "home_team" => "Arsenal",
            "away_team" => "Chelsea FC",
            "kickoff_at" => 1543741200,
            "created_at" => "2018-12-19T09:00:00Z"
          }
        ] |> Jason.encode!

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
