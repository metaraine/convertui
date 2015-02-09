assert = require('chai').assert
requireDirectory = require('require-directory')
converters = requireDirectory(module, '../app/converters')
conversionUtil = require('../app/conversion-util.js')(converters)

describe 'converters', ->

	for name, converter of converters
		it name + ' should have the required properties: convert, from, and to', ->
			assert.ok(converter.convert, 'should have a convert method')
			assert.ok(converter.from, 'should have an from property')
			assert.ok(converter.to, 'should have a to property')
