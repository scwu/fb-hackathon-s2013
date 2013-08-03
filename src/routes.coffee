controllers = require './controllers'

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    controllers.example.index req, res, next

  app.post '/api/user', (req, res, next) ->
    console.log controllers.api
    controllers.api.users.create req, res, next

  app.get '/api/user', (req, res, next) ->
    controllers.api.users.index req, res, next
