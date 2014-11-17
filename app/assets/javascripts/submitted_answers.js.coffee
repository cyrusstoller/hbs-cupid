# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#submitted_answer_intensity_0").click ->
    $(".accepted-answer-check-box").prop('checked', 'checked')

  $(".accepted-answer-check-box").click ->
    if $('.accepted-answer-check-box:checked').length == $('.accepted-answer-check-box').length
      $("#submitted_answer_intensity_0").prop('checked', 'checked')
      $(".intensity-radio-button").not("#submitted_answer_intensity_0").prop('disabled','disabled')
    else
      $(".intensity-radio-button").not("#submitted_answer_intensity_0").prop('disabled',false)
      if $("#submitted_answer_intensity_0:checked").length == 1
        $("#submitted_answer_intensity_1").prop('checked', 'checked')

$(document).ready(ready)
$(document).on('page:load', ready)