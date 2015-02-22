assert = require('chai').assert
converter = require('../app/converters/lowercase-to-uppercase.js')
conversionUtil = require('../app/conversion-util.js')(
	'lowercase-to-uppercase': converter
)

describe 'conversion-util', ->

	describe 'findConverter', ->

		it 'should find a converter with a matching input and output type', ->
			converter = conversionUtil.findConverter('text', 'uppercase')
			assert.ok(converter, 'finds the lowercase-to-uppercase converter')
			assert.ok(converter.convert, 'which as a convert method')

		it 'should support converter modules that return an array of converters', ->
			converter1 = conversionUtil.findConverter('csv', 'json')
			assert.ok(converter1, 'finds the csv-to-json converter')
			assert.ok(converter1.convert, 'which as a convert method')

			converter2 = conversionUtil.findConverter('json', 'csv')
			assert.ok(converter2, 'finds the json-to-csv converter')
			assert.ok(converter2.convert, 'which as a convert method')
