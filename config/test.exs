use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sugarlogapp, SugarlogappWeb.Endpoint,
  http: [port: 4001],
  server: true

# start hound with chrome headless and chrome driver
config :hound, driver: "chrome_driver", browser: "chrome_headless"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sugarlogapp, Sugarlogapp.Repo,
      adapter: Ecto.Adapters.MySQL,
      database: "sugarlogapp_test",
      username: "root",
      password: "root",
      hostname: "localhost",
      pool: Ecto.Adapters.SQL.Sandbox