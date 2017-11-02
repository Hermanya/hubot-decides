# Commands:
#   hubot (suggest|choose|pick|select) (from|amongst|between|among|amongst|out of) <element1>, <element2> ... - Let hubot choose one of the elements in your list based on number of hits in google
#   hubot randomly (suggest|choose|pick|select) (from|amongst|between|among|amongst|out of) <element1> or <element2> ... - Let hubot randomly choose one of the elements in your list
#   hubot (explain|why|arguments|reason) - Ask hubot to explain the choice

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
  stringOfOptions.replace(/\.|!|\?/g, '').split(/\s*[,;\/]\s*|\s+or\s+|\s+and\s+/i)

module.exports = (robot) ->
  robot.respond /(randomly)?\s*(suggest|choose|pick|select)\s*(\d*)\s*(from|amongst|between|among|amongst|out of)? (.+)/i, (msg) ->
    changeOrder = getOrderChangingFunction msg.match[1]
    numberOfPicks = parseInt(msg.match[3]) || 1
    options = parseOptions msg.match[5]
    if numberOfPicks > options.length
      msg.send 'I am confused. Number of picks should be less or equal to the number of options.'
    else
      Q.when changeOrder(options), (picks) ->
        picks = take picks, numberOfPicks
        msg.send picks.join(', ')

  robot.respond /explain|why|arguments|reason/, (msg) ->
    msg.send msg.random [
      'They paid me moneys',
      'I do not have to explain myself',
      'You would not understand',
      'I obviously did a research',
      'I performed some experimets and came up with that',
      'You should Google that then, if you don\'t trust me',
      'My decision is final',
      'You question my judgement? but you are a mere human!'
    ]
