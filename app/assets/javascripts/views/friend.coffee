define ["backbone", "marionette", "backbone.radio", "nunjucks", "text!templates/friend.html"], (Backbone, Marionette, Radio, nunjucks, friendTemplate) ->
  'use strict'

  class FriendView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'click .friend-info': 'showDetails'
      'click .assign-friend': 'assignFriend'
      'mouseout': 'hideDetails'

    initialize:->
      nunjucks.configure({ autoescape: true })
      @assChannel = Radio.channel('assignment')

    template:=>
      nunjucks.renderString(friendTemplate, @model.attributes)

    onRender:=>

    showDetails:->
      @$el.find('.friend').height(318)
      @$el.find('.details').show()

    hideDetails:->
      @$el.find('.details').hide()
      @$el.find('.friend').height(91)

    assignFriend:->
      @assChannel.trigger 'friend:assignmentRequest', @model.attributes

