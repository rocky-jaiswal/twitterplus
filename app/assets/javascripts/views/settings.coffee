define ["backbone", "marionette", "nunjucks", "text!templates/settings.html"], (Backbone, Marionette, nunjucks, settingsTemplate) ->
  'use strict'

  class SettingsView extends Backbone.Marionette.ItemView

    name: 'settingsView'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(settingsTemplate)
