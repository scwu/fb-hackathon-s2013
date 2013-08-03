controllers = require './controllers'

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    controllers.example.index req, res, next

  restfulRoutes app, 'users'

restfulRoutes = (app, model) ->
  app.get "/api/#{model}", (req, res, next) ->
    controllers.api[model].index req, res, next

  app.post "/api/#{model}", (req, res, next) ->
    controllers.api[model].create req, res, next

  app.put "/api/#{model}", (req, res, next) ->
    controllers.api[model].update req, res, next

  app.get "/api/#{model}/:id", (req, res, next) ->
    controllers.api[model].get req, res, next

  app.delete "/api/#{model}/:id", (req, res, next) ->
    controllers.api[model].delete req, res, next
