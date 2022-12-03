defmodule GptWeb.GameLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1>GPT: Graveyards, Pits & Treasure</h1>
      <p>Gems: <%= @gems %></p>
      <button phx-click="dig_up_grave" <%= if @dead, do: "disabled", else: "" %>>
        Dig up the next grave?
      </button>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, gems: 0, dead: false)}
  end

  def handle_event("dig_up_grave", _params, socket) do
    if socket.assigns.dead do
      {:noreply, socket}
    else
      if random_bool() do
        {:noreply, assign(socket, gems: socket.assigns.gems + 10)}
      else
        {:noreply, assign(socket, gems: "You fell into a pit. You are dead", dead: true)}
      end
    end
  end

  defp random_bool do
    :rand.uniform() < 0.9
  end
end
