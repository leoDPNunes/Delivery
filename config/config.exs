# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :delivery,
  ecto_repos: [Delivery.Repo]

config :delivery, Delivery.Users.Create, via_zipcode_adapter: Delivery.ViaCep.Client

# Confogiration to be able to use uuid v4
config :delivery, Delivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :delivery, DeliveryWeb.Auth.Guardian,
  issuer: "delivery",
  secret_key: "lTU3zRjOxlifEqDZ0MwnDYTMvSILHeFxo1a6RduKiEe6twwmbM1oQvTk1VUgB2bx"

config :delivery, DeliveryWeb.Auth.Pipeline,
  module: DeliveryWeb.Auth.Guardian,
  error_handler: DeliveryWeb.Auth.ErrorHandler

# Configures the endpoint
config :delivery, DeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kSl4XMKuDYwTV/9FsolSlbR22olBuht3ReW+CITgwtga90yGUR5nJ4m8OHea0h7E",
  render_errors: [view: DeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Delivery.PubSub,
  live_view: [signing_salt: "cHeqYr35"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
