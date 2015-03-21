define ["backbone", "marionette", "backbone.syphon", "nunjucks", "text!templates/settings.html"], (Backbone, Marionette, Syphon, nunjucks, settingsTemplate) ->
  'use strict'

  class SettingsView extends Backbone.Marionette.ItemView

    name: 'settingsView'

    events:
      "submit form#refresh-friends": "refreshFriends"

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(settingsTemplate)

    refreshFriends:(e)=>
      e.preventDefault()
      $.ajax({url: e.currentTarget.action, type: 'put', success: @friendsRefreshed, error: @friendsRefreshFailed})

    friendsRefreshed:(data)=>
      console.log data

    friendsRefreshedFailed:(data)=>
      console.log data
