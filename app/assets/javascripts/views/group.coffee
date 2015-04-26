define ["backbone", "marionette", "backbone.radio", "nunjucks", "text!templates/group.html"], (Backbone, Marionette, Radio, nunjucks, groupTemplate) ->
  'use strict'

  class GroupView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'click .select-group': 'addFriendToGroup'
      'click .delete-group': 'deleteGroup'

    initialize:->
      nunjucks.configure({ autoescape: true })
      @assChannel = Radio.channel('assignment')
      @assChannel.on('friend:assignmentRequest', @allowSelection)
      @assChannel.on('friend:assignmentSuccessful', @disableSelection)

    template:=>
      nunjucks.renderString(groupTemplate, @model.attributes)

    allowSelection:(friend)=>
      @selectedFriend = friend
      @$el.find('.select-group').removeClass('hidden')

    disableSelection:=>
      @$el.find('.select-group').addClass('hidden')

    addFriendToGroup:=>
      $.ajax
        url: "/groups/#{@model.id}/add_friend"
        method: "PUT"
        data: {friend_id: @selectedFriend.id}
        success: @friendAdded
        error: @error

    friendAdded:()=>
      @assChannel.trigger('friend:assignmentSuccessful')

    error:=>
      console.log "TODO"

    deleteGroup:=>
      @model.destroy()
