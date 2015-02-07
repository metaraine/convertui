assert = require('chai').assert
requireDirectory = require('require-directory')
converters = requireDirectory(module, '../app/converters')
conversionUtil = require('../app/conversion-util.js')(converters)

describe 'converters', ->

	for name, converter of converters
		it name + ' should have the required properties: convert, inputType, and outputType', ->
			assert.ok(converter.convert, 'should have a convert method')
			assert.ok(converter.inputType, 'should have an inputType property')
			assert.ok(converter.outputType, 'should have a outputType property')
