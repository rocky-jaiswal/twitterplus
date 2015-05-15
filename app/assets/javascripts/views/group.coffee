define ["backbone", "marionette", "backbone.radio", "nunjucks", "text!templates/group.html"], (Backbone, Marionette, Radio, nunjucks, groupTemplate) ->
  'use strict'

  class GroupView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'click .select-group': 'addFriendToGroup'
      'click .delete-group': 'deleteGroup'
      'drop': 'handleDrop'
      'dragover': 'allowDrop'

    initialize:->
      nunjucks.configure({ autoescape: true })
      @assChannel = Radio.channel('assignment')
      @assChannel.on('friend:assignmentRequest', @friendSelected)

    template:=>
      nunjucks.renderString(groupTemplate, @model.attributes)

    friendSelected:(friend)=>
      @$el.find('.group').addClass('highlighted')
      @selectedFriend = friend

    addFriendToGroup:=>
      $.ajax
        url: "/association"
        method: "POST"
        data: {friend_id: @selectedFriend.id, group_id: @model.id}
        success: @friendAdded
        error: @error

    error:=>
      console.log "TODO"

    deleteGroup:=>
      @model.destroy()

    allowDrop:(e)=>
      e.preventDefault()

    handleDrop:(e)=>
      $('.group').removeClass('highlighted')
      @addFriendToGroup()

    friendAdded:()=>
      @assChannel.trigger('friend:assignmentSuccessful')
