defmodule ExMatch.Provider do
  @type opts :: map()
  @type state :: {module(), opts()}

  @callback init() :: state
  @callback process(opts) :: state
end
