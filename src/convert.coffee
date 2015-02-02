# input: input text
# options: any other form values sent in the POST
module.exports = (input, options)->

	# process the input and return a value
	# also supports returning a promise for asynchronous processing
	'The input was converted to uppercase: ' + input.toString().toUpperCase()
