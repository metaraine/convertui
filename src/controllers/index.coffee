convert = require('./../convert.js')

module.exports =
	index: (req, res)->
		res.render 'index'

	convert: (req, res)->
		input = req.body.input
		delete req.body.input # remove from req.body to save memory
		res.send 200, convert(input, req.body)
