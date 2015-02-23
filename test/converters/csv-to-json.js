var assert = require('chai').assert;
var converter = require('../../app/converters/csv-to-json.js');

describe('csv-to-json', function() {

	it('should convert csv with a header row to json', function() {
		var csv = 'name,age,city\nraine,29,boulder\nphill,27,boulder';
		var expected = JSON.stringify([
			{ name: 'raine', age: '29', city: 'boulder' },
			{ name: 'phill', age: '27', city: 'boulder' }
		]);
		assert.equal(converter[0].convert(csv), expected);
	});

	it('should allow headers to be passed explicitly', function() {
		var csv = 'raine,29,boulder\nphill,27,boulder';
		var json = JSON.stringify([
			{ name: 'raine', age: '29', city: 'boulder' },
			{ name: 'phill', age: '27', city: 'boulder' }
		]);

		var output = converter[0].convert(csv, { headers: ['name', 'age', 'city'] })
		assert.equal(output, json, 'headers as array');

		var output = converter[0].convert(csv, { headers: 'name,age,city' })
		assert.equal(output, json, 'headers as string');
	});

});

describe('json-to-csv', function() {

	it('should convert json to csv with a header row', function() {
		var json = JSON.stringify([
			{ name: 'raine', age: '29', city: 'boulder' },
			{ name: 'phill', age: '27', city: 'boulder' }
		]);
		var csv = 'name,age,city\nraine,29,boulder\nphill,27,boulder';
		assert.equal(converter[1].convert(json), csv);
	});

});
