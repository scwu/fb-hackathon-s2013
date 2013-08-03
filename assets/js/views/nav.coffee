class App.NavView extends Backbone.View

  el: $ "#header"

  template: jade.templates.header

  initialize: ->
    @render()

  render: ->
    @$el.html @template()
    this

  home: =>
    App.router.navigate '/'
    App.router.showIndex()
