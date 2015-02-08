_ = require('lodash')
cint = require('cint')
requireDirectory = require('require-directory')
converters = requireDirectory(module, '../converters')
conversionUtil = require('../conversion-util.js')(converters)

module.exports =
	index: (req, res)->
		res.render 'index',
			converters: converters
			inputTypes: _.unique(cint.values(converters), (name, converter)->
				converter.inputType

	convert: (req, res)->
		input = req.body.input
		inputType = req.body.inputType
		outputType = req.body.outputType
		inputTypeVariation = req.body.inputTypeVariation
		outputTypeVariation = req.body.outputTypeVariation

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->

			converter = conversionUtil.findConverter inputType, inputTypeVariation, outputType, outputTypeVariation

			if converter
				resolve converter.convert(input)
			else
				throw new Error "Converter not defined for inputType: #{inputType}, inputTypeVariation: #{inputTypeVariation}, outputType: #{outputType}, outputTypeVariation: #{outputTypeVariation}"

		promisedOutput.then (value)->
			res.send value
		, (error)->
			console.error error.stack
			res.status(500)

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
