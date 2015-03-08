'use strict'

require.config
  shim:
    underscore:
      exports: '_'

    backbone:
      deps: ["underscore", "jquery"],
      exports: "Backbone"

    marionette:
      deps: ["backbone"],
      exports:"Marionette"

    nunjucks:
      exports: "nunjucks"

  paths:
    jquery: "/libs/bower_components/jquery/dist/jquery"
    underscore: "/libs/bower_components/underscore/underscore"
    backbone: "/libs/bower_components/backbone/backbone"
    marionette: "/libs/bower_components/marionette/lib/backbone.marionette"
    nunjucks: "/libs/nunjucks"

require ["backbone", "marionette", "jquery", "nunjucks"], (Backbone, Marionette, $, nunjucks) ->
  startApp = ->
    app = new Marionette.Application()
    app.addRegions({mainRegion: '#app-main'})

    nunjucks.configure({ autoescape: true })
    homeTemplate = nunjucks.renderString('<h2>Hello {{ username }}</h2>', { username: 'World!' })

    app.HomeView = Marionette.ItemView.extend({template: -> homeTemplate})
    homeView = new app.HomeView()

    app.on 'start', ->
      Backbone.history.start()
      app.mainRegion.show(homeView.render())

    app.start()

  $ ->
    startApp()
