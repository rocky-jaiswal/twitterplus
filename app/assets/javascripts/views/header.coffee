define ["backbone", "marionette", "nunjucks", "backbone.radio", "text!templates/header.html"], (Backbone, Marionette, nunjucks, Radio, headerTemplate) ->
  'use strict'

  class HeaderView extends Backbone.Marionette.ItemView

    initialize:->
      @navChannel = Radio.channel('navigation')
      @xhrChannel = Radio.channel('xhr')

      @navChannel.on 'navigation:homeView', @highlightMain
      @navChannel.on 'navigation:organizeView', @highlightOrganize
      @navChannel.on 'navigation:settingsView', @highlightSettings

      @xhrChannel.on 'xhrStart', @showLoading
      @xhrChannel.on 'xhrStop',  @hideLoading

      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(headerTemplate)

    highlightMain:=>
      $('#nav-organize').removeClass('active')
      $('#nav-settings').removeClass('active')
      $('#nav-home').addClass('active')

    highlightOrganize:=>
      $('#nav-settings').removeClass('active')
      $('#nav-home').removeClass('active')
      $('#nav-organize').addClass('active')

    highlightSettings:=>
      $('#nav-home').removeClass('active')
      $('#nav-organize').removeClass('active')
      $('#nav-settings').addClass('active')

    showLoading:=>
      $("ul.nav .loading").removeClass("hidden")

    hideLoading:=>
      $("ul.nav .loading").addClass("hidden")
