class App.IndexView extends Backbone.View

  el: $ '#content'

  template: jade.templates.index

  initialize: -> @render()

  render: ->
    @$el.html @template()
    this
