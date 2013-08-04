class App.EventModel extends Backbone.Model
  urlRoot: '/api/event/'

  idAttribute: '_id'

  defaults:
    'id' : ''
    'locations' : ''
    'date' : ''
    'invitees' : ''
    'responses' : ''
    'duration' : ''

  initialize: ->
    @loadInvitees()

  loadInvitees: ->
    ids = @get('invitees') || []
    @invitees = new Collections.Users({users: ids})
    @invitees.fetch()
