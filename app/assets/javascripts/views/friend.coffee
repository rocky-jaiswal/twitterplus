define ["backbone", "marionette", "backbone.radio", "nunjucks", "text!templates/friend.html"], (Backbone, Marionette, Radio, nunjucks, friendTemplate) ->
  'use strict'

  class FriendView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'click .friend-info': 'showHideDetails'
      'dragstart': 'handleDrag'

    initialize:->
      nunjucks.configure({ autoescape: true })
      @assChannel = Radio.channel('assignment')
      @detailsHidden = true

    template:=>
      nunjucks.renderString(friendTemplate, @model.attributes)

    onRender:=>

    showHideDetails:->
      if @detailsHidden
        @$el.find('.friend').height(318)
        @$el.find('.details').show()
        @detailsHidden = false
      else
        @$el.find('.details').hide()
        @$el.find('.friend').height(91)
        @detailsHidden = true

    handleDrag:(e)=>
      #jQuery event does not have dataTransfer :(
      @assChannel.trigger 'friend:assignmentRequest', @model.attributes

