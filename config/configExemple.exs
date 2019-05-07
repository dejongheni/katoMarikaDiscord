# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :katomarikadiscord, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:katomarikadiscord, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :nostrum,
  token: "yourKeyHere", # The token of your bot as a string
  num_shards: 2 # The number of shards you want to run your bot under, or :auto.

config :katomarikadiscord,
  prefix: ".",
  commander: "245967982080163841", #change with your ID if you want
  botID: "426055346079924234", #change with your bot ID
  pinoID: "403203900909289474"
