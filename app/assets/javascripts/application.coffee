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
    jquery:                "/libs/bower_components/jquery/dist/jquery"
    underscore:            "/libs/bower_components/underscore/underscore"
    backbone:              "/libs/bower_components/backbone/backbone"
    "backbone.babysitter": "/libs/bower_components/backbone.babysitter/backbone.babysitter"
    "backbone.radio":      "/libs/bower_components/backbone.radio/build/backbone.radio"
    "backbone.syphon":     "/libs/bower_components/backbone.syphon/lib/backbone.syphon"
    "radio.shim":          "/libs/radio.shim"
    "marionette":          "/libs/bower_components/marionette/lib/backbone.marionette"
    "text":                "/libs/bower_components/requirejs-text/text"
    "nunjucks":            "/libs/nunjucks"

  map:
    "*":
      "backbone.wreqr": "backbone.radio"

require ["marionette", "jquery", "radio.shim", "router/application_router", "views/layout"], (Marionette, $, Shim, ApplicationRouter, LayoutView) ->

  notifyXHRStart = ->
    Radio = require("backbone.radio")
    xhrChannel = Radio.channel("xhr")
    xhrChannel.trigger "xhrStart"

  notifyXHRStop = ->
    Radio = require("backbone.radio")
    xhrChannel = Radio.channel("xhr")
    xhrChannel.trigger "xhrStop"

  startApp = ->
    app = new Marionette.Application()

    app.on "start", ->
      $( document ).ajaxStart(notifyXHRStart)
      $( document ).ajaxStop(notifyXHRStop)
      layoutView = new LayoutView()
      layoutView.render()

      router = new ApplicationRouter(layoutView: layoutView)
      Backbone.history.start()
      router.navigate("/", {trigger: true})

    app.start()

  $ ->
    startApp()
