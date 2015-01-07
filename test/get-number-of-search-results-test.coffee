{expect} = require 'chai'
getNumberOfSearchResults = require '../src/get-number-of-search-results.coffee'

describe 'Getting number of search results', ->
  @timeout 30000

  it 'gets a number of search results', (done) ->
    getNumberOfSearchResults('apple').then (numberOfResults)->
      expect(numberOfResults).to.be.ok();
      done()

  it 'returns greater number of more obviously more popular search term', (done) ->
    smallerNumberOfResults = undefined;
    getNumberOfSearchResults('coffeescript')
    .then((number)->
      smallerNumberOfResults = number
      getNumberOfSearchResults('javascript')
    ).then((greaterNumberOfResults)->
      expect(greaterNumberOfResults).to.be.greaterThan(smallerNumberOfResults);
      done()
    )
