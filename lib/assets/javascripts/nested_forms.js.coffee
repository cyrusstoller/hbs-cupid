# Based on the javascript from http://railscasts.com/episodes/197-nested-model-form-part-2

jQuery ($) ->
  this.remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val("1")
    $(link).closest(".nested-field").hide()

  this.add_fields = (link, association, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + association, "g")
    $(link).closest(".form-group").before(content.replace(regexp, new_id))