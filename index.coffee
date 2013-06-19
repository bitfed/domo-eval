Sandbox = require 'sandbox'

modules.exports =
  'init': (connection) ->
    @connection = connection
  
  'match': 'eval '

  'onMessage': (nick, channel, msg, info) ->
    new Sandbox().run msg, (output) => 
      @connection.client.say channel, output.result
