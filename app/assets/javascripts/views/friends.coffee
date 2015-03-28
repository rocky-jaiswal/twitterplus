define ["backbone", "marionette", "nunjucks", "views/friend", "collections/groups", "text!templates/friends.html"], (Backbone, Marionette, nunjucks, FriendView, Groups, friendsTemplate) ->
  'use strict'

  class FriendsView extends Backbone.Marionette.CompositeView

    childView: FriendView

    childViewContainer: '.friends'

    initialize:->
      @groups = new Groups()
      @groups.fetch({reset: true, success: @groupsFetched})
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(friendsTemplate)

    groupsFetched:()=>
      console.log @groups
