use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :pxblog, Pxblog.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "#{System.get_env("POSTGRES_DB")}_test#{System.get_env("MIX_TEST_PARTITION")}" || "blog_test",
  hostname: System.get_env("POSTGRES_HOST") || "db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pxblog, PxblogWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :comeonin, bcrypt_log_rounds: 4
