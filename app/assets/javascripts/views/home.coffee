define ["backbone", "marionette", "nunjucks", "text!templates/home.html"], (Backbone, Marionette, nunjucks, homeTemplate) ->
  'use strict'

  class HomeView extends Backbone.Marionette.ItemView

    name: 'homeView'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(homeTemplate)
