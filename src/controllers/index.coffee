_ = require('lodash')
requireDirectory = require('require-directory')
converters = requireDirectory(module, '../converters')
conversionUtil = require('../conversion-util.js')(converters)

fromTypes =_(converters)
	.pluck('from')
	.sort()
	.uniq(true)
	.value()

toTypes =_(converters)
	.pluck('to')
	.sort()
	.uniq(true)
	.value()

module.exports =
	index: (req, res)->
		res.render 'index',
			converters: converters
			fromTypes: fromTypes
			toTypes: toTypes
			from: req.params[0] # matches the "x" capture group in the "/x-to-y" route
			to: req.params[1]		# matches the "y" capture group in the "/x-to-y" route

	convert: (req, res)->
		input = req.body.input
		from = req.body.from
		to = req.body.to

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->

			if !from
				return reject "No 'from' type specified"
			else if !to
				return reject "No 'to' type specified"

			converter = conversionUtil.findConverter from, to

			if !converter
				return reject "Converter not defined for #{from}-to-#{to}"

			resolve converter.convert(input)

		promisedOutput.then (value)->
			res.send value
		, (error)->
			console.error error
			res.status(500).send(error)

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
