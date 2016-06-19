defmodule Mix.Tasks.HotTopic.Serve.ProcesserTest do
  use ExUnit.Case, async: true
  alias Mix.Tasks.HotTopic.Serve.Processer

  setup do
    port = "#{:rand.uniform(65535)}"
    args = ["port:#{port}"]
    {:ok, [args: args, port: port]}
  end

  test "processing", %{args: args, port: port} do
    assert Processer.process(args) == %{"port" => port}
  end
end
