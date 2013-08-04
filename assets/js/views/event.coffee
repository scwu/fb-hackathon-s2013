class App.EventView extends Backbone.View

  el: $ '#content'

  template: jade.templates.event

  initialize: -> @render()

  render: ->
    @$el.html @template(@model.getJSON())
    this
