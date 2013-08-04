class App.EventListView extends Backbone.View

  el: $ '#content'

  template: jade.templates.events

  me : ''

  initialize: ->
    $.ajax
      url:"/api/me"
      success: (data) =>
        @me = data
        @current = new App.UserModel(@me)
        @render()

  events:
    'click' : 'open'

  render: ->
    @$el.html @template(@current.events.toJSON())
    this
