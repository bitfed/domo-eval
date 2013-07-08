domo = require '../index.coffee'
chai = require 'chai'  
chai.should()

initializeDomoWithMessageListener = (cb) ->
	domo.init 
		client: say: (channel, msg) =>
			cb(channel, msg)

describe 'Javascript calculation', ->
	it 'should evaluate to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '2'
			done()
		domo.onMessage 'nick', '#channel', '1 + 1'

describe 'Javascript function', ->
	it 'should evaluate to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '\'Domo\''
			done()
		domo.onMessage 'nick', '#channel', '(function(name) { return name; })("Domo")'

describe 'Coffeescript calculation', ->
	it 'should compile to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '1 + 1;'
			done()
		domo.onMessage 'nick', '#channel', '-c -v 1 + 1'
	
	it 'should evaluate to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '2'
			done()
		domo.onMessage 'nick', '#channel', '-c 1 + 1'

describe 'Coffeescript function', ->
	it 'should compile to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '(function(name) {  return name;\n})("Domo");\n'
			done()
		domo.onMessage 'nick', '#channel', '-c -v ((name)-> return name)("Domo")'
	
	it 'should evaluate to', (done) ->
		initializeDomoWithMessageListener (channel, msg) ->
			msg.should.equal '\'Domo\''
			done()
		domo.onMessage 'nick', '#channel', '-c ((name)-> return name)("Domo")'
