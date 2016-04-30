use Mix.Config

config :vuejs_on_phoenix, VuejsOnPhoenix.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "vuejs-phoenix.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info


# Configure your database
config :vuejs_on_phoenix, VuejsOnPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "vuejs_on_phoenix_prod",
  pool_size: 20,
  ssl: true
