module.exports = (converters)->

	# search for a converter that matches the given input and output type
	findConverter: (inputType, inputTypeVariation, outputType, outputTypeVariation)->

		# if there are only two arguments, treat the second argument as outputType
		args = arguments
		if arguments.length <= 2
			outputType = arguments[1]

		for name, converter of converters
			if inputType.match(converter.inputType) and
					outputType.match(converter.outputType) and
					(!inputTypeVariation or inputTypeVariation.match(converter.inputTypeVariation)) and
					(!outputTypeVariation or outputTypeVariation.match(converter.outputTypeVariation))
				return converter
