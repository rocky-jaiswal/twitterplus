define ["backbone", "marionette", "backbone.radio", "views/home", "views/groups", "views/settings", "views/header"], (Backbone, Marionette, Radio, HomeView, GroupsView, SettingsView, HeaderView) ->
  'use strict'

  class ApplicationRouter extends Backbone.Marionette.AppRouter

    routes:
      "": "main"
      "groups": "groups"
      "settings": "settings"

    main:->
      homeView = new HomeView()
      @display(homeView)
      

    groups:->
      groupsView = new GroupsView()
      @display(groupsView)

    settings:->
      settingsView = new SettingsView()
      @display(settingsView)

    display:(view)->
      view.render()
      view.getRegion('header').show(new HeaderView())
      channel = Radio.channel('navigation')
      channel.trigger "navigation:#{view.name}"
      
