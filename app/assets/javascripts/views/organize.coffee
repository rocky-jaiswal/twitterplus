define ["backbone", "marionette", "nunjucks", "views/groups", "views/friends", "collections/friends", "text!templates/organize.html"], (Backbone, Marionette, nunjucks, GroupsView, FriendsView, Friends, organizeTemplate) ->
  'use strict'

  class OrganizeView extends Backbone.Marionette.LayoutView

    name: 'organizeView'

    regions:
      friends: "#friends-layout"
      groups:  "#groups-layout"

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(organizeTemplate)

    onBeforeShow:=>
      friends = new Friends()
      friends.fetch({reset: true})
      friendsView = new FriendsView(collection: friends)
      @getRegion('friends').show(friendsView)
      @getRegion('groups').show(new GroupsView())
