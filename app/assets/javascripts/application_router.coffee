define ["backbone", "marionette", "views/home", "views/groups", "views/settings"], (Backbone, Marionette, HomeView, GroupsView, SettingsView) ->
  'use strict'

  class ApplicationRouter extends Backbone.Marionette.AppRouter

    routes:
      "": "main"
      "groups": "groups"
      "settings": "settings"

    main:->
      homeView = new HomeView()
      homeView.render()

    groups:->
      groupsView = new GroupsView()
      groupsView.render()

    settings:->
      settingsView = new SettingsView()
      settingsView.render()
