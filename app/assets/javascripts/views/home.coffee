define ["backbone", "marionette", "underscore", "nunjucks", "models/timeline", "text!templates/home.html"], (Backbone, Marionette, _, nunjucks, Timeline, homeTemplate) ->
  'use strict'

  class HomeView extends Backbone.Marionette.ItemView

    name: 'homeView'

    events:
      "click #refresh-tweets": "refreshTweets"

    initialize:->
      @model = new Timeline()
      @model.on("sync", @refreshView)
      @fetchTweets()
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(homeTemplate, {keys: _.keys(@model.attributes), data: @model.attributes})

    refreshView:=>
      @render()

    refreshTweets:=>
      $.ajax
        url:     "/timeline/refresh"
        method:  "PUT"
        success: @fetchTweets
        error:   @error

    fetchTweets:=>
      @model.fetch()

    error:(args...)=>
      #TODO: Fix this
      console.log "Error!"