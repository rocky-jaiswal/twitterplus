define ["backbone", "marionette", "nunjucks"], (Backbone, Marionette, nunjucks) ->
  'use strict'

  class HomeView extends Backbone.Marionette.LayoutView

    el: '#app-main'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString('<h2>Hello {{ username }}</h2>', { username: 'World!' })
