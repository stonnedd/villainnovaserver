# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :autocar,
  ecto_repos: [Autocar.Repo]

# Configures the endpoint
config :autocar, AutocarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Go7Glv5twMNMttS+T3d7kZko77jn5hrnsx/r/Y2DYhRgbCyzwqF/mkzfLEnnwvbV",
  render_errors: [view: AutocarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Autocar.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :autocar, Autocar.Guardian,
  allowed_algos: ["HS512"],
  issuer: "autocar",
  secret_key: System.get_env("GUARDIAN_SECRET") || "roVW67MgLEK1iqcTY96EmNOCAj0AVXPt2ifOBKe712C8/HEwDrw7LWileJV+PobY",
  verify_module: Guardian.JWT, 
  ttl: { 30, :days }, 
  serializer: Autocar.Guardian
  #verify_issuer: true,
  
  #secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
