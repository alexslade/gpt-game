defmodule Gpt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GptWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gpt.PubSub},
      # Start Finch
      {Finch, name: Gpt.Finch},
      # Start the Endpoint (http/https)
      GptWeb.Endpoint
      # Start a worker by calling: Gpt.Worker.start_link(arg)
      # {Gpt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gpt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GptWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
