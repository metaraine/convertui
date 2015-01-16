convert = require('./../convert.js')

module.exports =
	index: (req, res)->
		res.render 'index'

	convert: (req, res)->
		input = req.body.input
		delete req.body.input # remove from req.body to save memory

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->
			resolve convert(input, req.body)

		promisedOutput.then (value)->
			res.send 200, value
