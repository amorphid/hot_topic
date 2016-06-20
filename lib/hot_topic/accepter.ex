defmodule HotTopic.Accepter do
  require Logger

  defstruct [:listener,
             :port,
             {:listen_retry_delay, 5000},
             {:opts, [{:active, false},
                      {:reuseaddr, true},
                      :binary]}]

  def listen!(%__MODULE__{listen_retry_delay: delay, port: port}=state) do
    case listen(state) do
      {:ok, listener} ->
        Logger.info("HotTopic now listening on port #{port}")
        new_state = %__MODULE__{state | listener: listener}
        accept!(new_state)
      reason          ->
        Logger.error("""
        HotTopic failed to listen on port #{port} because => #{inspect(reason)}
        Will retry connection in #{delay} milliseconds
        """)
        :timer.sleep(delay)
        listen!(state)
    end
  end

  def accept(%__MODULE__{listener: listener}=_state) do
    :gen_tcp.accept(listener)
  end

  defp accept!(%__MODULE__{port: port}=state) do
    case accept(state) do
      {:ok, receiver} ->
        IO.puts("connection accepted!")
        accept!(state)
      reason ->
        Logger.error("""
        HotTopic failed to accept on port #{port} because => #{inspect(reason)}
        Restarting listener
        """)
        exit(reason)
    end
  end

  def start_link(%__MODULE__{}=state) do
    accepter = spawn_link(__MODULE__, :listen!, [state])
    {:ok, accepter}
  end

  defp listen(%__MODULE__{port: port, opts: opts}=_state) do
    :gen_tcp.listen(port, opts)
  end
end
