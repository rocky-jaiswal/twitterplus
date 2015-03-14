define ["backbone", "marionette", "backbone.radio", "views/home", "views/friends", "views/settings", "views/header", "collections/friends"], (Backbone, Marionette, Radio, HomeView, FriendsView, SettingsView, HeaderView, Friends) ->
  'use strict'

  class ApplicationRouter extends Backbone.Marionette.AppRouter

    routes:
      "": "main"
      "friends": "friends"
      "settings": "settings"

    main:->
      homeView = new HomeView()
      @display(homeView)

    friends:->
      friends = new Friends()
      friends.fetch({reset: true})
      friendsView = new FriendsView(collection: friends)
      @display(friendsView)

    settings:->
      settingsView = new SettingsView()
      @display(settingsView)

    display:(view)->
      @options.layoutView.getRegion('main').show(view)
      @options.layoutView.getRegion('header').show(new HeaderView())
      channel = Radio.channel('navigation')
      channel.trigger "navigation:#{view.name}"
