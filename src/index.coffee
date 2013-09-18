Sandbox = require 'sandbox'
coffee  = require 'coffee-script'

getCode = (res, next) ->
  res.code = res.splats[0]
  next()

module.exports.init = (domo) ->
  domo.route '!eval', (res) -> # TODO HELP
    @say res.channel, """
    Domo-eval - Javascript evaluator for Domo
    usage: !eval <flags> <JavaScript|CoffeeScript>
    Flags:
      -c [-v] Evaluate coffeescript, verbose compiled JavaScript with -v flag
    """
  domo.route '!eval -c -v *', getCode, (res) ->
    try
      res.code = coffee.compile(res.code, bare: true).replace('\n', '')
    catch e
      return @say res.channel, e.message
    @say res.channel, res.code

  domo.route '!eval -c *', getCode, (res) ->
    try
      res.code = coffee.compile(res.code, bare: true).replace('\n', '')
    catch e
      return @say res.channel, e.message

    new Sandbox().run res.code, (output) =>
      @say res.channel, output.result

  domo.route '!eval *', getCode, (res) ->
    new Sandbox().run res.code, (output) =>
      @say res.channel, output.result

