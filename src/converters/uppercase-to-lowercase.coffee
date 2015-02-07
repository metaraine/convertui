convert = (input, options)->
	input.toString().toLowerCase()

module.exports =
	inputType: 'text'
	outputType: 'text'
	outputTypeVariation: 'lowercase'
	convert: convert
