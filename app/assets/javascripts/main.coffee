# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#
#document.querySelector('button').addEventListener 'click', ((e) ->
#  @removeEventListener 'click', clickHandler, false
#  e.preventDefault()
#  self = this
#  setTimeout (->
#    self.className = 'loading'
#    return
#  ), 125
#  setTimeout (->
#    self.className = 'ready'
#    return
#  ), 4300
#  return
#), false

$(document).ready ->
  $('.js-datepicker').datepicker()
  $('#overlayTrigger').click (event) ->
    event.preventDefault()
    $('body').chardinJs 'start'


  $('form.tickets_form').trigger('submit.rails')
