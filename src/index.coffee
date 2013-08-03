path = require 'path'

express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
jade = require 'jade'

app = express()

# Set port
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000

# Get out config
config = require './config'
app.configure 'production', 'development', 'testing', ->
  # Initialize the config
  config.setEnvironment app.settings.env

# Use Rails-esque asset pipeline
app.use assets()
app.use express.static process.cwd() + '/public'
# Automagic parsing of JSON post body, et cetera
app.use express.bodyParser()
# Jade, since raw HTML is hard
app.set 'view engine', 'jade'

# Set up our routes
routes = require './routes'
routes app

module.exports = app
