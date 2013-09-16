Sandbox = require 'sandbox'
coffee  = require 'coffee-script'

parseFlags = (str) ->
  regex = /^-([a-z]*)\s/i
  flags = []

  match = (s) ->
    return unless (m = s.match(regex))?
    flags.push m[1]
    s = str = s.replace(regex, '')
    match(s)

  match(str)
  return [flags, str]

class DomoEval
  constructor: ->
    @match = 'eval '

  init: (@domo) =>

  coffeeEval: (str, cb) =>
    try
      cb null, coffee.compile(str, bare: true).replace('\n', '')
    catch e
      return cb(e)

  jsEval: (str, cb) =>
    new Sandbox().run str, (output) =>
      cb null, output.result

  onMessage: (nick, channel, msg) =>
    [flags, msg] = parseFlags(msg)

    if flags.indexOf('c') > -1
      return @coffeeEval msg, (err, result) =>

        return @domo.client.say(channel, err.stack.split("\n")[0]) if err?

        return @domo.client.say(channel, result) if flags.indexOf('v') > -1

        @jsEval result, (err, output) =>
          @domo.client.say channel, output

    # Default to JavaScript evaluation
    @jsEval msg, (err, output) =>
      @domo.client.say channel, output

module.exports = new DomoEval
