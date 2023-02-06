defmodule Meilisearch do
  @moduledoc """
  A client for [MeiliSearch](https://meilisearch.com).
  The following Modules are provided for interacting with Meilisearch:
  * `Meilisearch.Health`: [Health API](https://docs.meilisearch.com/references/health.html)
  """

  use GenServer

  defp to_name(name), do: :"__MODULE__:#{name}"

  def start_link(name, opts) do
    GenServer.start_link(__MODULE__, opts, name: to_name(name))
  end

  @impl true
  def init(opts) do
    {:ok, Meilisearch.Client.new(opts)}
  end

  @impl true
  def handle_call(:client, _, client) do
    {:reply, client, client}
  end

  def client(name) do
    GenServer.call(to_name(name), :client)
  end
end
