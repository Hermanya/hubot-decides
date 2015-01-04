cheerio = require 'cheerio'
request = require 'request'
Q = require 'q'
module.exports = (term) ->
  Q.Promise (resolve, reject) ->
    term = encodeURIComponent term
    request "https://www.google.com/search?q=#{term}", (error, res, body) ->
      if error
        reject error.message
      $ = cheerio.load(body)
      numberOfSearchResults = Number $('#resultStats').text().match(/\d/g).join('')
      resolve numberOfSearchResults


# module.exports = (term) ->
#   Q.Promise (resolve) ->
#     resolve Math.floor(Math.random() * 100)
