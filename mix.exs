defmodule HotTopic.Mixfile do
  use Mix.Project

  def project do
    [app: :hot_topic,
     version: "0.0.1",
     elixir: "~> 1.2",
     dialyzer: dialyzer,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {HotTopic, []}]
  end

  defp deps do
    [{:dialyxir, "~> 0.3", only: [:dev]}]
  end

  defp dialyzer do
    [flags: ~w(--fullpath
               -Werror_handling
               -Wno_opaque
                -Woverspecs
               -Wrace_conditions
               -Wunknown
               -Wunmatched_returns)]
  end
end
