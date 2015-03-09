define ["backbone", "marionette", "views/home_view"], (Backbone, Marionette, HomeView) ->
  'use strict'

  class ApplicationRouter extends Backbone.Marionette.AppRouter

    routes:
      "": "main"

    main:->
      homeView = new HomeView()
      homeView.render()
