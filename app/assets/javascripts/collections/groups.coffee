define ["backbone", "marionette", "models/group"], (Backbone, Marionette, Group) ->
  'use strict'

  class Groups extends Backbone.Collection

    model: Group

    url: '/groups'
