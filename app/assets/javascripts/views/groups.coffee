define ["backbone", "marionette", "nunjucks", "text!templates/groups.html"], (Backbone, Marionette, nunjucks, groupsTemplate) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.ItemView

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(groupsTemplate)