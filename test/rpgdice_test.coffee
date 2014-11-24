chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'rpgdice', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/rpgdice')(@robot)

  it 'registers a respond listener for "roll"', ->
    expect(@robot.respond).to.have.been.calledWith(/roll (?:([0-9]+)d([0-9]+))(?: (.*))*/i)

  it 'registers a respond listener for "ore"', ->
    expect(@robot.respond).to.have.been.calledWith(/ore (\d+)( \d+)?( \d+)?( .+)?/im)