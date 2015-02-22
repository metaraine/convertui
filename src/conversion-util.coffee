cint =             require('cint')
_ =                require('lodash')
requireDirectory = require('require-directory')

# get the converter modules
converterModules = requireDirectory(module, '../converters')

# normalize the converter modules, since some may be arrays and some may be single modules
converters = _.flatten cint.toObject converterModules, (filename, converter)->
	_.isArray(converter.convert) ? converter :
	converter.convert ? [converter] :
	throw new Error('Invalid converter. Converter module must return an object with from, to, and convert properties, or an array of such objects.')

# get the unique from and to types
fromTypes = _(converters)
	.pluck('from')
	.sort()
	.uniq(true)
	.value()

toTypes = _(converters)
	.pluck('to')
	.sort()
	.uniq(true)
	.value()

module.exports =

	getFromTypes:  _.constant(fromTypes),
	getToTypes:    _.constant(toTypes),
	getConverters: _.constant(converters)

	# search for a converter that matches the given input and output type
	findConverter: (from, to)->

		if !from
			throw new Error("Must specify a \"from\" type. Received #{from}.")
		else if !to
			throw new Error("Must specify a \"to\" type. Received #{to}.")

		for name, converter of converters
			if from.match(converter.from) and to.match(converter.to)
				return converter

