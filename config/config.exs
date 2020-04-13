# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :apis,
  generators: [context_app: false]

# Configures the endpoint
config :apis, Apis.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pXJs7B8+hFz3H4mcy/q9yIf2/So41jJRHwCkYEBUp2X6l7/MHcIzEUBDBZgKn2tE",
  render_errors: [view: Apis.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Apis.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "/zYr1uT/"]

config :apis,
  ecto_repos: [Apis.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :apis, Apis.Endpoint,
  url: [host: "localhost"],
  server: true,
  secret_key_base: "GivARm//IhknrdcYXaoUz5PsV74lCEEd0clyY9Y5nHYmdVt7E1SbkgP0vHRbI4sL",
  render_errors: [view: Apis.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Apis.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "qExyEay8"]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :kafka_ex,
  # A list of brokers to connect to. This can be in either of the following formats
  #
  #  * [{"HOST", port}...]
  #  * CSV - `"HOST:PORT,HOST:PORT[,...]"`
  #  * {mod, fun, args}
  #  * &arity_zero_fun/0
  #  * fn -> ... end
  #
  # If you receive :leader_not_available
  # errors when producing messages, it may be necessary to modify "advertised.host.name" in the
  # server.properties file.
  # In the case below you would set "advertised.host.name=localhost"
  # brokers: [
  #   {"kafka-cluster-kafka-bootstrap.strimzi.svc.cluster.local", 9094}
  # ],
  # brokers: [
  #   {"10.23.246.160", 9092}
  # ],
  brokers: [
    {"kafka-cluster-kafka-bootstrap.strimzi.svc.cluster.local", 9092}
  ],
  #
  # OR:
  # brokers: "localhost:9092,localhost:9093,localhost:9094"
  #
  # It may be useful to configure your brokers at runtime, for example if you use
  # service discovery instead of storing your broker hostnames in a config file.
  # To do this, you can use `{mod, fun, args}` or a zero-arity function, and [`KafkaEx`](KafkaEx.html)
  # will invoke your callback when fetching the `:brokers` configuration.
  # Note that when using this approach you must return a list of host/port pairs.
  #
  # the default consumer group for worker processes, must be a binary (string)
  #    NOTE if you are on Kafka < 0.8.2 or if you want to disable the use of
  #    consumer groups, set this to :no_consumer_group (this is the
  #    only exception to the requirement that this value be a binary)
  # consumer_group: "kafka_ex",
  # Set this value to true if you do not want the default
  # [`KafkaEx.Server`](KafkaEx.Server.html) worker to start during application start-up -
  # i.e., if you want to start your own set of named workers
  disable_default_worker: false,
  # Timeout value, in msec, for synchronous operations (e.g., network calls).
  # If this value is greater than GenServer's default timeout of 5000, it will also
  # be used as the timeout for work dispatched via KafkaEx.Server.call (e.g., KafkaEx.metadata).
  # In those cases, it should be considered a 'total timeout', encompassing both network calls and
  # wait time for the genservers.
  sync_timeout: 3000,
  # Supervision max_restarts - the maximum amount of restarts allowed in a time frame
  max_restarts: 10,
  # Supervision max_seconds -  the time frame in which :max_restarts applies
  max_seconds: 60,
  # Interval in milliseconds that GenConsumer waits to commit offsets.
  commit_interval: 5_000,
  # Threshold number of messages consumed for GenConsumer to commit offsets
  # to the broker.
  commit_threshold: 100,
  # This is the flag that enables use of ssl
  use_ssl: false,
  # see SSL OPTION DESCRIPTIONS - CLIENT SIDE at http://erlang.org/doc/man/ssl.html
  # for supported options
  # ssl_options: [
  #   cacertfile: File.cwd!() <> "/ssl/ca-cert",
  #   certfile: File.cwd!() <> "/ssl/cert.pem",
  #   keyfile: File.cwd!() <> "/ssl/key.pem"
  # ],
  # set this to the version of the kafka broker that you are using
  # include only major.minor.patch versions.  must be at least 0.8.0
  kafka_version: "2.4.1",
  auto_offset_reset: :latest

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
