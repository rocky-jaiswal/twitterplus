define ["backbone", "marionette", "backbone.radio", "nunjucks", "views/friend", "collections/groups", "text!templates/friends.html"], (Backbone, Marionette, Radio, nunjucks, FriendView, Groups, friendsTemplate) ->
  'use strict'

  class FriendsView extends Backbone.Marionette.CompositeView

    childView: FriendView

    childViewContainer: '.friends'

    initialize:->
      nunjucks.configure({ autoescape: true })
      assChannel = Radio.channel('assignment')
      assChannel.on('friend:assignmentSuccessful', @refreshFriends)

    template:=>
      nunjucks.renderString(friendsTemplate)

    refreshFriends:=>
      @collection.fetch({reset: true})
