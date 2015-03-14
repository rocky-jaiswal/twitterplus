define ["backbone", "marionette", "models/friend"], (Backbone, Marionette, Friend) ->
  'use strict'

  class Friends extends Backbone.Collection

    model: Friend

    url: '/friends'
