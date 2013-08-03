#= require vendor/jquery-1.9.1
#= require vendor/underscore
#= require vendor/backbone

#= require template
#= require_tree views/

class App.Router extends Backbone.Router

  routes:
    '': 'showApp'

  initialize: ->
    App.navView = new App.NavView

  showApp: ->
    App.indexView = new App.IndexView

App.router = new App.Router

Backbone.history.start()
