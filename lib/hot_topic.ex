defmodule HotTopic do
  alias HotTopic.AppSupervisor

  @type default :: 5700

  @type key :: :port

  @type port_number :: integer()

  @type value :: any()

  @spec start(term(), term()) :: AppSupervisor.t
  def start(_,_) do
    AppSupervisor.start_link(%AppSupervisor{port: port})
  end

  @spec get_env(key(), default()) :: value()
  defp get_env(key, default) do
    Application.get_env(:hot_topic, key, default)
  end

  @spec port() :: port_number()
  defp port do
    get_env(:port, 5700)
    |> to_string
    |> String.to_integer
  end
end
