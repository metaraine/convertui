module.exports = (converters)->

	# search for a converter that matches the given input and output type
	findConverter: (from, to)->

		if !from
			throw new Error("Must specify a \"from\" type. Received #{from}.")
		else if !to
			throw new Error("Must specify a \"to\" type. Received #{to}.")

		for name, converter of converters
			if from.match(converter.from) and to.match(converter.to)
				return converter
