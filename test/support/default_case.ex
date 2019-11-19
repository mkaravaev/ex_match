defmodule ExMatch.DefaultCase do
  use ExUnit.CaseTemplate

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ExMatch.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ExMatch.Repo, {:shared, self()})
    end

    :ok
  end

  using do
    quote do
      alias ExMatch.Repo
    end
  end

end
