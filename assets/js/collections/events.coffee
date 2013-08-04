class App.EventCollection extends Backbone.Collection
  initialize: (models, args) ->
    @url = -> args.user.url() + '/events'

  model: App.UserModel


