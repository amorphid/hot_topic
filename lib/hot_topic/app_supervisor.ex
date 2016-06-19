defmodule HotTopic.AppSupervisor do
  use Supervisor
  alias HotTopic.Accepter

  @type accepter :: map()

  @type app_supervisor :: :ignore | {:ok,{{:one_for_all,non_neg_integer(),pos_integer()} | {:one_for_one,non_neg_integer(),pos_integer()} | {:rest_for_one,non_neg_integer(),pos_integer()} | {:simple_one_for_one,non_neg_integer(),pos_integer()} | %{},[{term(),{atom() | tuple(),atom(),:undefined | [any()]},:permanent | :temporary | :transient, :brutal_kill | :infinity | non_neg_integer(),:supervisor | :worker, :dynamic | [atom() | tuple()]} | %{}]}}

  @type children :: [{term(),{atom() | tuple(),atom(),[any()]},:permanent | :temporary | :transient,:brutal_kill | :infinity | non_neg_integer(),:supervisor | :worker, :dynamic | [atom() | tuple()]},...]

  @type empty_children :: list()

  @type opts :: [{:strategy, :one_for_one},...]

  @type supervisor_ast :: {:ok, {{term(), term(), term()}, term()}}

  @type t :: :ignore | {:error,term()} | {:ok,pid()}

  @type worker :: :worker | :supervisor

  defstruct [:port]

  @spec init(any()) :: app_supervisor()
  def init(%__MODULE__{}=state) do
    []
    |> add_accepter(state)
    |> add_supervisor(opts)
  end

  @spec start_link(accepter) :: :ignore | {:error,term()} | {:ok,pid()}
  def start_link(%__MODULE__{}=state) do
    Supervisor.start_link(__MODULE__, state)
  end

  @spec add_accepter(empty_children(), accepter()) :: children()
  defp add_accepter(children, %__MODULE__{port: port}=_state) do
    children ++ [worker(Accepter, [%Accepter{port: port}])]
  end

  @spec add_supervisor(children(),opts()) :: supervisor_ast()
  defp add_supervisor(children, opts) do
    supervise(children, opts)
  end

  @spec opts() :: opts()
  defp opts do
    [strategy: :one_for_one]
  end
end
