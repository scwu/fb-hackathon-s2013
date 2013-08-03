module.exports =

  normalize: (date) ->
    date.setSeconds 0
    date.setMilliseconds 0
    if date.getMinutes < 30
      date.setMinutes 30
    else
      date.setHours ((date.getHours() + 1) % 24)
      date.setMinutes 0

    date
