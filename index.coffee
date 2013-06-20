Sandbox = require 'sandbox'

modules.exports =
  'match': 'eval '
  'onMessage': (nick, channel, msg, info) ->
    new Sandbox().run msg, (output) => 
      @connection.client.say channel, output.result
