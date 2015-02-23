assert = require('chai').assert
requireDirectory = require('require-directory')
conversion = require('../app/conversion.js')

describe 'converters', ->

	for name, converter_s of conversion.getConverters()
		converters = [].concat(converter_s)
		for converter in converters
			it "#{converter.from}-#{converter.to} should have the required properties: convert, from, and to", ->
				assert.ok(converter.convert, 'should have a convert method')
				assert.ok(converter.from, 'should have a from property')
				assert.ok(converter.to, 'should have a to property')
