define ["backbone", "marionette", "backbone.syphon", "nunjucks", "views/group","text!templates/groups.html"], (Backbone, Marionette, Syphon, nunjucks, GroupView, groupsTemplate) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.CompositeView

    childView: GroupView

    events:
      "submit form#add-group": "addGroup"

    childViewContainer: '.groups'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(groupsTemplate)

    addGroup:(e)=>
      e.preventDefault()
      group = Syphon.serialize(@)
      @collection.create group
      $("#new-group-name").val("")
