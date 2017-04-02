use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :brainhub, Brainhub.Endpoint,
  secret_key_base: "EylsTU9JF7xkaw7jSYRaROqnZ1mZC187/LQ44qrmLJTCaeoIqTndNlve9vsLYjzF"

# Configure your database
config :brainhub, Brainhub.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "bulat",
  password: "password",
  database: "brainhub_dev",
  pool_size: 20

config :guardian, Guardian,
  secret_key: "zTSdkVl5i5ISVK-yz10X2w"