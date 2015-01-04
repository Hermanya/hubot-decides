# Commands:
#   test/decide-test.coffee

getNumberOfSearchResults = require './get-number-of-search-results.coffee'
Q = require 'q'
{shuffle, take, chain} = require 'lodash'

getPromiseOfSearchResults = (options) ->
  Q.all options.map (option) ->
    getNumberOfSearchResults option

sortByNumberOfSearchResults = (options) ->
  getPromiseOfSearchResults(options).then (numbersOfResults) ->
    chain(options)
    .map (option, index) ->
      term: option,
      numberOfResults: numbersOfResults[index]
    .sortBy('numberOfResults')
    .reverse()
    .pluck('term')
    .value()


getOrderChangingFunction = (isRandom) ->
  if isRandom
    return shuffle
  else
    return sortByNumberOfSearchResults


parseOptions = (stringOfOptions) ->
  stringOfOptions.replace(/\.|!|\?/g, '').split(/\s*[,;\/]\s*|\s*or\s*/i)

module.exports = (robot) ->
  robot.hear /(randomly)?\s*(suggest|choose|pick|select)\s*(\d*)\s*(from|amongst|between|among|amongst|out of)? (.+)/i, (msg) ->
    changeOrder = getOrderChangingFunction msg.match[1]
    numberOfPicks = parseInt(msg.match[3]) || 1
    options = parseOptions msg.match[5]
    if numberOfPicks > options.length
      msg.send 'I am confused. Number of picks should be less or equal to the number of options.'
    else
      Q.when changeOrder(options), (picks) ->
        picks = take picks, numberOfPicks
        msg.send picks.join(', ')

  robot.hear /explain|why|arguments/, (msg) ->
    msg.send msg.random [
      'They paid me moneys',
      'I do not have to explain myself',
      'You would not understand',
      'I obviously did a research',
      'I performed some experimets and came up with that',
    ]
