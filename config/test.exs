use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rocketlivery, Rocketlivery.Repo,
  username: "postgres",
  password: "rpi1234",
  database: "rocketlivery_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Github actions
if System.get_env("GITHUB_ACTIONS") do
  config :rocketlivery, Rocketlivery.Repo,
    username: "postgres",
    password: "postgres"
end

config :rocketlivery, Rocketlivery.Users.Create, via_cep_adapter: Rocketlivery.ViaCep.ClientMock

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rocketlivery, RocketliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
