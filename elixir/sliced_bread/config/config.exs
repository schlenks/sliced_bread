# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sliced_bread,
  ecto_repos: [SlicedBread.Repo]

# Configures the endpoint
config :sliced_bread, SlicedBreadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qH1nGZFmPlnEEIukNvaAI4aLb/FOm0g057HBytQYFryjyYZPo0hbxY4JKHvEtPzd",
  render_errors: [view: SlicedBreadWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SlicedBread.PubSub,
  live_view: [signing_salt: "ryi1fKoW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
