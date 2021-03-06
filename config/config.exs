# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sugarlogapp,
  ecto_repos: [Sugarlogapp.Repo]

# Configures the endpoint
config :sugarlogapp, SugarlogappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2Uk8zi1ALrAB0kLcPg1i9a+/K5cQghQPLxxLdD9RnF5oGV/dBOGgCZ5kdeGGfr5h",
  render_errors: [view: SugarlogappWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sugarlogapp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# guardian config
config :sugarlogapp, Sugarlogapp.Guardian,
       issuer: "sugarlogapp",
       secret_key: "9EnrwmK8CUR+gsuWM6ASgsijZ+aMC2cT04SBQo5wmqBpAFgYBmlGBVSs5Xv46W/D"

#  config bamboo for sendgrid
config :sugarlogapp, Sugarlogapp.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY") || 'test12345'

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"