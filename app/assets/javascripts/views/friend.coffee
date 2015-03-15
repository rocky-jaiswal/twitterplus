define ["backbone", "marionette", "nunjucks", "text!templates/friend.html"], (Backbone, Marionette, nunjucks, friendTemplate) ->
  'use strict'

  class FriendView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'mouseover': 'showDetails'
      'mouseout': 'hideDetails'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(friendTemplate, @model.attributes)

    showDetails:->
      @$el.find('.friend').height(350)
      @$el.find('.details').show()

    hideDetails:->
      @$el.find('.details').hide()
      @$el.find('.friend').height(125)
