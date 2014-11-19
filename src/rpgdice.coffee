# Description:
#   Rolls dice!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot roll 2d6
#
# Author:
#   dualmoon

module.exports = (robot) ->

  # Helpers
  randint = (sides) ->
    return Math.round(Math.random()*(sides-1))+1
  rolldice = (sides, num) ->
    if num is 1
      return randint sides
    else
      results = []
      results.push(randint sides) for [1..num]
      return results

  robot.hear /roll ([0-9]+d[0-9]+)(?: (.*))*/i, (msg) ->
    matches = msg.match[1].split('d')
    num = matches[0]
    sides = matches[1]
    msg.send(rolldice sides, num)
