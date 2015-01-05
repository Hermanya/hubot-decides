Robot = require 'hubot/src/robot'
{expect} = require 'chai'
{TextMessage} = require 'hubot/src/message'

describe 'Decision making', ->
  {robot, user, adapter} = {}
  @timeout 30000

  beforeEach (done) ->
    robot = new Robot(null, 'mock-adapter', false, 'hubot')
    robot.adapter.on 'connected', ->
      require('../src/decide.coffee')(robot)
      user = robot.brain.userForId '1', {
        name: 'mocha',
        room: '#mocha'
      }
      adapter = robot.adapter
      done()
    robot.run()

  afterEach ->
    robot.shutdown();

  it 'cannot pick more than the number of options', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.match(/confused/);
      done();
    adapter.receive new TextMessage(user, 'hubot choose 3 between red or blue.');

  it 'randomly picks one amongst options', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.match(/red|green|blue/);
      done();
    adapter.receive new TextMessage(user, 'hubot randomly pick from red/green/blue.');

  it 'randomly picks 2 out of first four letters', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.match(/(a|b|c|d), (a|b|c|d)/);
      done();
    adapter.receive new TextMessage(user, 'hubot randomly select 2 out of a,  b or c, d..');

  it 'educatedly picks one amongst options', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.match(/javascript/);
      done();
    adapter.receive new TextMessage(user, 'hubot pick from javascript/coffescript.');

  it 'picks 2 out of Harry Potter characters', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.match(/Harry Potter, Hermione Granger/);
      done();
    adapter.receive new TextMessage(user, 'hubot select 2 out of Harry Potter, Neville Longbottom, Hermione Granger, Ginny Weasley');

  it 'explains why', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.be.ok;
      done();
    adapter.receive new TextMessage(user, 'hubot explain why');
