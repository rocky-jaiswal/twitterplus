define ["backbone", "marionette", "nunjucks", "text!templates/settings.html", "text!templates/layout.html"], (Backbone, Marionette, nunjucks, settingsTemplate, layoutTemplate) ->
  'use strict'

  class SettingsView extends Backbone.Marionette.LayoutView

    el: '#app-layout'

    name: 'settingsView'

    regions:
      header: "#app-header"
      main:   "#app-main"

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(layoutTemplate)
      #nunjucks.renderString(settingsTemplate)
