path = require 'path'

express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
jade = require 'jade'
mongoose = require 'mongoose'

app = express()

# Set port
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000

# Get out config
config = require './config'
app.configure 'production', 'development', 'testing', ->
  # Initialize the config
  config.setEnvironment app.settings.env

if app.settings.env != 'production'
  mongoose.connect 'mongodb://localhost/example'
else
  console.log \
    'If you are running in production, ' +
    'you may want to modify the mongoose connect path'

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
