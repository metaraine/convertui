var assert = require('chai').assert;
var converter = require('../../app/converters/uppercase-to-lowercase.js');

describe('uppercase-to-lowercase', function() {
	it('should convert uppercase text to lowercase text', function() {
		assert.equal(converter.convert('HELLO'), 'hello');
	})
})
