define ["backbone", "marionette", "nunjucks", "text!templates/friend.html"], (Backbone, Marionette, nunjucks, friendTemplate) ->
  'use strict'

  class FriendView extends Backbone.Marionette.ItemView

    tagName: 'div'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(friendTemplate, @model.attributes)
