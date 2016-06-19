defmodule Mix.Tasks.HotTopic.Serve do
  alias Mix.Tasks.HotTopic.Serve.Processer

  @type command_line_args :: maybe_improper_list()

  @spec run(command_line_args) :: nil
  def run(args) do
    %{} = Processer.process(args)
    start
  end

  @spec start() :: nil
  defp start do
    HotTopic.start
  end
end
