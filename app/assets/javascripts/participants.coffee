# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('input[type=radio]').change (e) ->
    console.log $(this).val()
    if $(this).val() == 'yes'
      i = 0
      while i < $('.proxy > input').length
        $('.proxy > input')[i].disabled = false
        $('.proxy > input')[i].placeholder = ''
        i++
    else
      i = 0
      while i < $('.proxy > input').length
        $('.proxy > input')[i].disabled = true
        $('.proxy > input')[i].placeholder = 'No proxy'
        i++
    return
  return

# ---
# generated by js2coffee 2.2.0