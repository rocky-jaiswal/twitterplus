define ["backbone", "marionette", "nunjucks", "views/friend", "text!templates/friends.html"], (Backbone, Marionette, nunjucks, FriendView, friendsTemplate) ->
  'use strict'

  class FriendsView extends Backbone.Marionette.CompositeView

    childView: FriendView

    childViewContainer: '.friends'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(friendsTemplate)
