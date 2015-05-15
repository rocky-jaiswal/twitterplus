define ["backbone", "marionette", "backbone.radio", "backbone.syphon", "nunjucks", "views/group","text!templates/groups.html"], (Backbone, Marionette, Radio, Syphon, nunjucks, GroupView, groupsTemplate) ->
  'use strict'

  class GroupsView extends Backbone.Marionette.CompositeView

    childView: GroupView

    events:
      "submit form#add-group": "addGroup"

    childViewContainer: '.groups'

    initialize:->
      nunjucks.configure({ autoescape: true })
      assChannel = Radio.channel('assignment')
      assChannel.on('friend:assignmentSuccessful', @refreshGroups)

    template:=>
      nunjucks.renderString(groupsTemplate)

    addGroup:(e)=>
      e.preventDefault()
      group = Syphon.serialize(@)
      @collection.create(group)
      $("#new-group-name").val('')

    refreshGroups:=>
      @collection.fetch({reset: true})
