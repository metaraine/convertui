var assert = require('chai').assert;
var converter = require('../../app/converters/lowercase-to-uppercase.js');

describe('lowercase-to-uppercase', function() {
	it('should convert lowercase text to uppercase text', function() {
		assert.equal(converter.convert('hello'), 'HELLO');
	})
})
