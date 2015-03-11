define ["backbone", "marionette", "nunjucks", "text!templates/layout.html"], (Backbone, Marionette, nunjucks, layoutTemplate) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.LayoutView

    el: '#app-layout'

    name: 'groupsView'

    regions:
      header: "#app-header"
      main:   "#app-main"

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(layoutTemplate)
