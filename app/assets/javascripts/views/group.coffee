define ["backbone", "marionette", "backbone.radio", "nunjucks", "text!templates/group.html"], (Backbone, Marionette, Radio, nunjucks, groupTemplate) ->
  'use strict'

  class GroupView extends Backbone.Marionette.ItemView

    tagName: 'div'

    events:
      'click .select-group': 'addUserToGroup'

    initialize:->
      nunjucks.configure({ autoescape: true })
      @assChannel = Radio.channel('assignment')
      @assChannel.on('user:assignmentRequest', @allowSelection)

    template:=>
      nunjucks.renderString(groupTemplate, @model.attributes)

    onRender:=>

    allowSelection:(user)=>
      @$el.find('.select-group').removeClass('hidden')
      @selectedUser = user

   adduserToGroup:=>
     #associate user to group
