defmodule GptWeb.GameLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1>GPT: Graveyards, Pits & Treasure</h1>
      <p>Gems: <%= @gems %></p>
      <button phx-click="dig_up_grave">Dig up the next grave?</button>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, gems: 0)}
  end

  def handle_event("dig_up_grave", _params, socket) do
    if random_bool() do
      {:noreply, assign(socket, gems: socket.assigns.gems + 10)}
    else
      {:noreply, assign(socket, gems: "You fell into a pit. You are dead")}
    end
  end

  defp random_bool do
    :rand.uniform() > 0.5
  end
end
