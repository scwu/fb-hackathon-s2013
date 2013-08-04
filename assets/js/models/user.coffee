class App.UserModel extends Backbone.Model
  urlRoot: '/api/users/'

  idAttribute: '_id'

  defaults:
    'id' : ''
    'firstName' : ''
    'lastName' : ''

  initialize: ->
    @loadEvents()

  loadEvents: ->
    @events = new Collections.Events([], {user: @id})
    @events.fetch()
