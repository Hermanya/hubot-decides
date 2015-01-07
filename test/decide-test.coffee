humock = require 'mock-hubot'
{expect} = require 'chai'

describe 'Decision making', ->
  @timeout 30000

  beforeEach (done) ->
    humock.start ->
      humock.learn require '../src/decide.coffee'
      done()

  afterEach ->
    humock.shutdown();

  it 'cannot pick more than the number of options', (done) ->
    humock.test 'hubot choose 3 between red or blue.', (envelope, strings) ->
      expect(strings[0]).to.match(/confused/);
      done();

  it 'randomly picks one amongst options', (done) ->
    humock.test 'hubot randomly pick from red/green/blue.', (envelope, strings) ->
      expect(strings[0]).to.match(/red|green|blue/);
      done();

  it 'randomly picks 2 out of first four letters', (done) ->
    humock.test 'hubot randomly select 2 out of a,  b or c, d..', (envelope, strings) ->
      expect(strings[0]).to.match(/(a|b|c|d), (a|b|c|d)/);
      done();

  it 'educatedly picks one amongst options', (done) ->
    humock.test 'hubot pick from javascript/coffescript.', (envelope, strings) ->
      expect(strings[0]).to.match(/javascript/);
      done();

  it 'picks 2 out of Harry Potter characters', (done) ->
    humock.test 'hubot select 2 out of Harry Potter, Neville Longbottom, Hermione Granger, Ginny Weasley', (envelope, strings) ->
      expect(strings[0]).to.match(/Harry Potter, Hermione Granger/);
      done();

  it 'explains why', (done) ->
    humock.test 'hubot explain why', (envelope, strings) ->
      expect(strings[0]).to.be.ok;
      done();
