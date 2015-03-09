define ["backbone", "marionette", "nunjucks"], (Backbone, Marionette, nunjucks) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.LayoutView

    el: '#app-main'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString('<h2>Groups</h2>')
