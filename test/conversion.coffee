assert = require('chai').assert
converter = require('../app/converters/lowercase-to-uppercase.js')
conversion = require('../app/conversion.js')

describe 'conversion', ->

	describe 'findConverter', ->

		it 'should find a converter with a matching input and output type', ->
			converter = conversion.findConverter('text', 'uppercase')
			assert.ok(converter, 'finds the lowercase-to-uppercase converter')
			assert.ok(converter.convert, 'which as a convert method')

		it 'should support converter modules that return an array of converters', ->
			converter1 = conversion.findConverter('csv', 'json')
			assert.ok(converter1, 'finds the csv-to-json converter')
			assert.ok(converter1.convert, 'which as a convert method')

			converter2 = conversion.findConverter('json', 'csv')
			assert.ok(converter2, 'finds the json-to-csv converter')
			assert.ok(converter2.convert, 'which as a convert method')
