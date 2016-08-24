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

  it 'listens for "roll" and responds to a valid roll', ->
    expect(@robot.respond).to.have.been.calledWith(/roll (?:([1-9][0-9]*)d([1-9][0-9]*))(?:\+([1-9][0-9]*))?(?: (.*))*$/i)
    expect(@robot.respond).to.have.been.calledWithMatch sinon.match( (val) ->
      val.test /roll 2d4/
      val.test /roll 1d6/
      val.test /roll 2d4+8/
      val.test /roll 5d8+10 A note/
      val.test /roll 1d2 Another note/
    )
    expect(@robot.respond).to.not.have.been.calledWithMatch sinon.match( (val) ->
      val.test /roll 1dN/
      val.test /roll blah/
      val.test /roll 0d0/
      val.test /roll 1d2+0/
    )

  it 'listens for "ore" and responds to a valid roll', ->
    expect(@robot.respond).to.have.been.calledWith(/ore (\d+)( \d+)?( \d+)?( .+)?/im)
    expect(@robot.respond).to.have.been.calledWithMatch sinon.match( (val) ->
      val.test /ore 2/
      val.test /ore 2 test/
      val.test /ore 2 4/
      val.test /ore 2 4 test/
      val.test /ore 2 4 5/
      val.test /ore 2 4 5 test/
    )
    expect(@robot.respond).to.not.have.been.calledWithMatch sinon.match( (val) ->
      val.test /ore test/
    )
