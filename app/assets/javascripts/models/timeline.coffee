define ["backbone", "marionette"], (Backbone, Marionette) ->
  'use strict'

  class Timeline extends Backbone.Model

    urlRoot: '/timeline'
