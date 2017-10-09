# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :brainhub,
  ecto_repos: [Brainhub.Repo]

# Configures the endpoint
config :brainhub, BrainhubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hIGeXFB6V6FYA+pijz1M+vnG/tZ21GTbjctGRyO8cmZNKXcI3j2E00EVC6SrLWAZ",
  render_errors: [view: BrainhubWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Brainhub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  issuer: "Brainhub",
  ttl: { 3, :days },
  verify_issuer: true,
  serializer: Brainhub.GuardianSerializer
