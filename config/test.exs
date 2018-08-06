use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sugarlogapp, SugarlogappWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
# config :sugarlogapp, Sugarlogapp.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "sugarlogapp_test",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox
config :sugarlogapp, Sugarlogapp.Repo,
      adapter: Ecto.Adapters.MySQL,
      database: "sugarlogapp_test",
      username: "root",
      password: "root",
      hostname: "localhost",
      pool: Ecto.Adapters.SQL.Sandbox