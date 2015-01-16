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
			res.send value

	upload: (req, res)->

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->
			for name,fileInfo of req.files
				# console.log 'fileInfo', fileInfo.buffer.toString()
				resolve convert(fileInfo.buffer)

		promisedOutput.then (value)->
			# console.log 'body', req.body, 'query', req.query, 'files', req.files
			res.send
				success: true
				output: value
