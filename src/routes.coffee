controllers = require './controllers'

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    controllers.example.index req, res, next

  app.get '/calendarAuth', (req, res, next) ->
    res.redirect '/info'

  app.get '/partials/:view', (req, res, next) ->
    res.render 'partials/' + req.params.view, {layout: false}

  restfulRoutes app, 'users'
  app.get '/api/users/:id/events', (req, res, next) ->
    controllers.api.users.getEvents req, res, next
  app.post '/api/users/:id/events', (req, res, next) ->
    controllers.api.users.createEvent req, res, next

  restfulRoutes app, 'events'
  app.post '/api/events/:id/responses', (req, res, next) ->
    controllers.api.events.createResponse req, res, next

  app.get '/api/events/:id/ranking', (req, res, next) ->
    controllers.api.events.ranking req, res, next

  restfulRoutes app, 'responses'

  app.get '/*', (req, res, next) ->
    console.log "took generic route"
    controllers.example.index req, res, next


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
