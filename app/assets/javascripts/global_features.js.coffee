$(document).on 'turbolinks:load', ->
  x = new Date
  console.log "Success " + x
  dataFormat = "YYYY-MM-DD HH:mm:ss"
  for i in [0...$('.timestamp').length]
    timeString = $('.timestamp')[i].innerHTML.split(" ")
    stringDatetime = timeString[0] + " " + timeString[1]
    $('.timestamp')[i].innerHTML = moment(stringDatetime, dataFormat).format('LLLL')