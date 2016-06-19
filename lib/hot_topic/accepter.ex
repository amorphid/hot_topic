defmodule HotTopic.Accepter do
  defstruct [:port]

  def init(%__MODULE__{}=_state) do
  end

  def start_link(%__MODULE__{}=state) do
    accepter = spawn_link(__MODULE__, :init, [state])
    {:ok, accepter}
  end
end
