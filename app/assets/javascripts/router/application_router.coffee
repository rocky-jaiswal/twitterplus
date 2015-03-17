define ["backbone", "marionette", "backbone.radio", "views/home", "views/organize", "views/settings", "views/header"], (Backbone, Marionette, Radio, HomeView, OrganizeView, SettingsView, HeaderView) ->
  'use strict'

  class ApplicationRouter extends Backbone.Marionette.AppRouter

    routes:
      "": "main"
      "organize": "organize"
      "settings": "settings"

    main:->
      homeView = new HomeView()
      @display(homeView)

    organize:->
      organizeView = new OrganizeView()
      @display(organizeView)

    settings:->
      settingsView = new SettingsView()
      @display(settingsView)

    display:(view)->
      @options.layoutView.getRegion('main').show(view)
      @options.layoutView.getRegion('header').show(new HeaderView())
      channel = Radio.channel('navigation')
      channel.trigger "navigation:#{view.name}"
