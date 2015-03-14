define ["backbone", "marionette", "nunjucks", "views/friend", "text!templates/friends.html"], (Backbone, Marionette, nunjucks, FriendView, friendsTemplate) ->
  'use strict'

  class FriendsView extends Backbone.Marionette.CollectionView

    name: 'friendsView'

    tagName: 'div'

    childView: FriendView

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(friendsTemplate)
