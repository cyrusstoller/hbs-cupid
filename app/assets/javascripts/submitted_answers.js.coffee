# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#submitted_answer_intensity_0").click ->
    $(".accepted-answer-check-box").prop('checked', 'checked')

  $(".accepted-answer-check-box").click ->
    # setting intensity to irrelevant if all boxes are checked
    if $('.accepted-answer-check-box:checked').length == $('.accepted-answer-check-box').length
      $("#submitted_answer_intensity_0").prop('checked', 'checked')
      $(".intensity-radio-button").not("#submitted_answer_intensity_0").prop('disabled','disabled')
    else
      $(".intensity-radio-button").not("#submitted_answer_intensity_0").prop('disabled',false)
      if $("#submitted_answer_intensity_0:checked").length == 1
        $("#submitted_answer_intensity_1").prop('checked', 'checked')

    # disabling the submit button if no boxes are checked
    if $('.accepted-answer-check-box:checked').length == 0
      $(".submitted_answer_commit").addClass('disabled')
    else
      $(".submitted_answer_commit").removeClass('disabled')

  # disabling the form submit if no boxes are checked
  $("#new_submitted_answer").submit ->
    if $('.accepted-answer-check-box:checked').length == 0
      false
    else
      true

  # enabling the submit button if some buttons are checked
  if $('.accepted-answer-check-box:checked').length > 0
    $(".submitted_answer_commit").removeClass('disabled')

$(document).ready(ready)
$(document).on('page:load', ready)