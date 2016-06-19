defmodule Mix.Tasks.HotTopic.Serve do
  alias HotTopic.AppSupervisor
  alias Mix.Tasks.HotTopic.Serve.Processer

  @type command_line_args :: maybe_improper_list()

  @spec run(command_line_args()) :: AppSupervisor.t
  def run(args) do
    %{} = Processer.process(args)
    HotTopic.start(:unused, :unused)
  end
end
