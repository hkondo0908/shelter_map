defmodule ShelterMap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ShelterMap.Repo,
      # Start the Telemetry supervisor
      ShelterMapWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ShelterMap.PubSub},
      # Start the Endpoint (http/https)
      ShelterMapWeb.Endpoint
      # Start a worker by calling: ShelterMap.Worker.start_link(arg)
      # {ShelterMap.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShelterMap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShelterMapWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
