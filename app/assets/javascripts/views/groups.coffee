define ["backbone", "marionette", "nunjucks", "views/group","text!templates/groups.html"], (Backbone, Marionette, nunjucks, GroupView, groupsTemplate) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.CompositeView

    childView: GroupView

    childViewContainer: '.groups'

    initialize:->
      nunjucks.configure({ autoescape: true })

    template:=>
      nunjucks.renderString(groupsTemplate)
