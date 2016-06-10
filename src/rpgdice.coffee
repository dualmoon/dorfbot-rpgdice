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
#   hubot ore 10
#
# Author:
#   dualmoon

module.exports = (robot) ->

  # Helpers
  count = (string, search) ->
    string.split(search).length-1
  randint = (sides) ->
    return Math.round(Math.random()*(sides-1))+1
  rolldice = (sides, num) ->
    if num is 1
      return 0+randint sides
    else
      results = []
      results.push(randint sides) for [1..num]
      return results
  matchORE = (rolls) ->
    matches = []
    rolls = rolls.join(',')
    for num in [1..10]
      occurrences = count(rolls,num)
      if occurrences > 1
        matches.push "#{occurrences}x#{num}"
    if matches.length > 0
      return matches
    else
      return false

  # Basic die roller
  robot.respond /roll (?:([0-9]+)d([0-9]+))(?:\+([0-9])+)?(?: (.*))*/i, (msg) ->
    num = msg.match[1]
    sides = msg.match[2]
    modifier = false or msg.match[3]
    note = false or msg.match[4]
    rolls = rolldice sides, num
    rolls.sort()
    message = []
    message.push "You rolled #{rolls.toString().split(',').join(', ')}"
    message.push "+#{modifier}" if modifier
    if rolls.length > 1
      rollsTotal = 0
      rollsTotal += i for i in rolls
      rollsTotalPlus += modifier if modifier
      message.push "for a total of #{rollsTotalPlus}."
    else
      message.push '.'
    message.push " Note: #{note}" if note
    msg.send message.join(' ')

  robot.respond /ore (\d+)( \d+)?( \d+)?( .+)?/im, (msg) ->
    ### <number of dice> [<called>] [<expert>] [<note>] ###

    num = msg.match[1]
    if num > 10 or num < 1
      return msg.send 'You must roll between 1 and 10 dice'
    rolls = rolldice(10,num)

    if msg.match[2] and typeof(msg.match[2]) is 'number'
      called = parseInt(msg.match[2])
      if called > 10 or called < 1
        return msg.send "They're d10s, you idiot. You can't call a side that doesn't exist."
      else
        rolls.push called

    if msg.match[4]
      note = ", Note: #{msg.match[4]}"
    else
      note = ""

    if msg.match[3] and typeof(msg.match[3]) is 'number'
      expert = parseInt(msg.match[3])
      if expert > 10 or expert < 1
        return msg.send "For someone with \"expert\" dice you sure aren't an expert at basic math. Expert dice have 10 sides."
      else
        rolls.push expert

    rolls.sort()
    #msg.send "num: #{num}, note: #{note}, called: #{called}, expert: #{expert}, rolls: #{rolls}"
    matches = matchORE(rolls)
    msg.send "You rolled: #{rolls.join(', ')}, Sets: #{matches.join (', ')}#{note}"
