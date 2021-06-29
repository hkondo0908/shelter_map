# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shelter_map,
  ecto_repos: [ShelterMap.Repo]

# Configures the endpoint
config :shelter_map, ShelterMapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KAIwCAI317R7pboh42nRidYiwS/QViIzWs9qPz3/f3CBZHhUZzJ3d7hWp2rn+iL9",
  render_errors: [view: ShelterMapWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ShelterMap.PubSub,
  live_view: [signing_salt: "ZL1svYVp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
