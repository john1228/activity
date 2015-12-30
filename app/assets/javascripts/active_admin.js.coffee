#= require active_admin/base
#= require jquery.timepicker

$ ->
  $("input.time-picker").timepicker({
    'scrollDefault': 'now',
    'showDuration': true,
    'timeFormat': 'H:i'
  });