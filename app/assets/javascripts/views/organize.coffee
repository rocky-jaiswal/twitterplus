define ["backbone", "marionette", "nunjucks", "views/groups", "views/friends", "collections/friends", "collections/groups", "text!templates/organize.html"], (Backbone, Marionette, nunjucks, GroupsView, FriendsView, Friends, Groups, organizeTemplate) ->
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
      @getRegion('friends').show(new FriendsView(collection: friends))

      groups = new Groups()
      groups.fetch({reset: true})
      @getRegion('groups').show(new GroupsView(collection: groups))
