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
      return 0+randint sides
    else
      results = []
      results.push(randint sides) for [1..num]
      return results

  # Basic die roller
  robot.respond /roll (?:([0-9]+)d([0-9]+))(?: (.*))*/i, (msg) ->
    num = msg.match[1]
    sides = msg.match[2]
    rolls = rolldice sides, num
    rolls.sort()
    rollsTotal = 0
    rollsTotal += i for i in rolls
    msg.send "You rolled #{rolls.toString().split(',').join(', ')} for a total of #{rollsTotal}"

  robot.respond /ore (\d+)( \d+)?( \d+)?( .+)?/im, (msg) ->
    ### <number of dice> [<called>] [<expert>] [<note>] ###

    num = msg.match[1]
    if num > 10 or num < 1
      return msg.send "You must roll between 1 and 10 dice"
    rolls = rolldice(10,num)

    note = called = expert = ""

    called = parseInt(msg.match[2])
    if called isnt NaN
      if called > 10 or called < 1
        return msg.send "They're d10s, you idiot. You can't call a side that doesn't exist."
      else
        rolls.push called

    note = msg.match[4] if msg.match[4]

    expert = parseInt(msg.match[3])
    if expert isnt NaN
      if expert > 10 or expert < 1
        return msg.send "For someone with \"expert\" dice you sure aren't an expert at basic math. Expert dice have 10 sides."
      else
        rolls.push expert

    rolls.sort()
    msg.send "num: #{num}, note: #{note}, called: #{called}, expert: #{expert}, rolls: #{rolls}"
