defmodule Mix.Tasks.HotTopic.Serve.Processer do
  @type args :: Collectable.t()
  @type command_line_args :: maybe_improper_list()
  @type processed_args :: [any()]
  @type value :: term()


  @args ["port"]

  @spec process(command_line_args()) :: args()
  def process(args) when is_list(args) do
    args
    |> process_args()
    |> to_map()
    |> set_port()
  end

  @spec process_args(command_line_args()) :: processed_args()
  defp process_args(args) do
    for arg <- args, is_binary(arg),
                     arg =~ ~r/.+:.+/,
                     String.starts_with?(arg, @args) do
      arg
      |> String.split(":", parts: 2)
      |> List.to_tuple
    end
  end

  @spec put_env(:port, value()) :: :ok
  defp put_env(key, value) do
    old_value = Application.get_env(:hot_topic, key)
    new_value = value || old_value
    Application.put_env(:hot_topic, key, new_value)
  end

  @spec set_port(args()) :: args()
  defp set_port(args) do
    put_env(:port, args["port"])
    args
  end

  @spec to_map(processed_args()) :: args()
  defp to_map(args) do
    Enum.into(args, %{})
  end
end
