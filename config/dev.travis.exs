use Mix.Config

config :brainhub, Brainhub.Endpoint,
  secret_key_base: "EylsTU9JF7xkaw7jSYRaROqnZ1mZC187/LQ44qrmLJTCaeoIqTndNlve9vsLYjzF"

# Configure your database
config :brainhub, Brainhub.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "brainhub_dev",
  pool_size: 20

config :guardian, Guardian,
  secret_key: "zTSdkVl5i5ISVK-yz10X2w"