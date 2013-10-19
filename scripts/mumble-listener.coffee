# Description:
#   Connect to and query a Mumble server
#
# Dependencies:
#    None
#
# Configuration:
#   HUBOT_MUMBLE_SERVER
#	HUBOT_MUMBLE_PORT
#   HUBOT_MUMBLE_USERNAME
#   HUBOT_MUMBLE_PASSWORD
#
# Commands:
#   hubot <keyword> tweet - Returns a link to a tweet about <keyword>
#
# Notes:
#   There's an outstanding issue on AvianFlu/ntwitter#110 for search and the v1.1 API.
#   sebhildebrandt is a fork that is working, so we recommend that for now. This
#   can be removed after the issue is fixed and a new release cut, along with updating the dependency
#
# Author:
#   atmos, technicalpickles

module.exports = (robot) ->
  robot.router.get '/user/:name/joined/:room', (req, res) ->
    userName = req.params.name
    room = req.params.room
    
    robot.messageRoom "#{userName} hopped on Mumble!"
    
    res.end "Noted!"


# Ugly hack to get all hubot’s rooms,
# pending an official and cross-adapters API
getAllRooms = (robot) ->
  
  # With the IRC adapter, rooms are located
  # in robot.adapter.bot.opt.channels
  adapter = robot.adapter
  return adapter.bot.opt.channels  if adapter and adapter.bot and adapter.bot.opt and adapter.bot.opt.channels
  
  # Search in env vars
  for i of process.env
    return process.env[i].split(",")  if /^HUBOT_.+_ROOMS/i.exec(i) isnt null