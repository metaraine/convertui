_ = require('lodash')
conversion = require('../conversion.js')

module.exports =
	index: (req, res)->
		res.render 'index',
			converters: conversion.getConverters()
			fromTypes: conversion.getFromTypes()
			toTypes: conversion.getToTypes()
			from: req.params[0] # matches the "x" capture group in the "/x-to-y" route
			to: req.params[1]		# matches the "y" capture group in the "/x-to-y" route

	convert: (req, res)->
		input = req.body.input
		from = req.body.from
		to = req.body.to

		# TODO: get options from form
		options = {}

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->

			if !from
				return reject "No 'from' type specified"
			else if !to
				return reject "No 'to' type specified"

			converter = conversion.findConverter from, to

			if !converter
				return reject "Converter not defined for #{from}-to-#{to}"

			resolve converter.convert(input, options)

		promisedOutput.then (value)->
			res.send value
		, (error)->
			console.error error, error.stack
			res.status(500).send(error)

	upload: (req, res)->

		# TODO: get options from form
		options = {}

		# wrap in a promise to handle Promises or scalar values
		promisedOutput = new Promise (resolve, reject)->
			for name,fileInfo of req.files
				# console.log 'fileInfo', fileInfo.buffer.toString()
				resolve convert(fileInfo.buffer, options)

		promisedOutput.then (value)->
			# console.log 'body', req.body, 'query', req.query, 'files', req.files
			res.send
				success: true
				output: value
