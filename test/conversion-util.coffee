assert = require('chai').assert
converter = require('../app/converters/lowercase-to-uppercase.js')
conversionUtil = require('../app/conversion-util.js')(
	'lowercase-to-uppercase': converter
)

describe 'conversion-util', ->

	describe 'findConverter', ->
		it 'should find a converter with a matching input and output type', ->
			converter = conversionUtil.findConverter('text', null, 'text', 'uppercase')
			assert.ok(converter, 'finds the lowercase-to-uppercase converter with "text, text, uppercase"')
