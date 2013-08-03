controllers = require './controllers'

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    controllers.example.index req, res, next
