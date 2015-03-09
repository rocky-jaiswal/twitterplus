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

require ["marionette", "jquery", "application_router"], (Marionette, $, ApplicationRouter) ->
  startApp = ->
    app = new Marionette.Application()

    app.on 'start', ->
      router = new ApplicationRouter()
      Backbone.history.start()
      router.navigate("/", {trigger: true})

    app.start()

  $ ->
    startApp()
