define ["backbone", "marionette", "nunjucks", "backbone.radio", "text!templates/header.html"], (Backbone, Marionette, nunjucks, Radio, headerTemplate) ->
  'use strict'

  class HeaderView extends Backbone.Marionette.ItemView

    initialize:->
      @channel = Radio.channel('navigation')
      @channel.on 'navigation:homeView', @highlightMain
      @channel.on 'navigation:organizeView', @highlightOrganize
      @channel.on 'navigation:settingsView', @highlightSettings
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(headerTemplate)

    highlightMain:=>
      $('#nav-home').addClass('active')

    highlightOrganize:=>
      $('#nav-organize').addClass('active')

    highlightSettings:=>
      $('#nav-settings').addClass('active')
