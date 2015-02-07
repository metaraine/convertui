# input: input text
# options: all other form values sent in the POST
convert = (input, options)->

	# process the input and return a value
	# also supports returning a promise for asynchronous processing
	input.toString().toUpperCase()

module.exports =
	inputType: 'text'
	outputType: 'text'
	outputTypeVariation: 'uppercase'
	convert: convert
