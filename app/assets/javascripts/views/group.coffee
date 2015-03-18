define ["backbone", "marionette", "nunjucks", "text!templates/group.html"], (Backbone, Marionette, nunjucks, groupTemplate) ->
  'use strict'

  class GroupView extends Backbone.Marionette.ItemView

    tagName: 'div'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(groupTemplate, @model.attributes)
