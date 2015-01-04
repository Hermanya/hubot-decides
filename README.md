# hubot-decide

A hubot script that does the things

See [`src/decide.coffee`](src/decide.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-decide --save`

Then add **hubot-decide** to your `external-scripts.json`:

```json
["hubot-decide"]
```

## Sample Interaction

```
user1>> hubot hello
hubot>> hello!
```

# chai = require 'chai'
# sinon = require 'sinon'
# chai.use require 'sinon-chai'

# expect = chai.expect

# describe 'decide', ->
#   beforeEach ->
#     @robot =
#       respond: (string)->
#         if ()
#       hear: sinon.spy()

#     require('../src/decide')(@robot)

#   it 'registers a respond listener', ->
#     @robot.respond('pick 2 from red,green, blue or yellow')

#   it 'registers a hear listener', ->
#     expect(@robot.hear).to.have.been.calledWith(/orly/)

# describe 'looking up number of search results', ->
#   lookup = require('../src/lookup-number-of-search-results');

#   it 'returns the number of results', (done) ->
#     lookup 'apple', (result) ->
#       try
#         expect(result).to.be.greaterThan(0);
#         done()
#       catch e
#         done(e)