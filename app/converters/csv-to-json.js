var _ = require('lodash')

module.exports = [

	/*******************************
	 * csv-to-json
	 *******************************/
	{
		from: 'csv',
		to: 'json',
		fromOptions: {
			headers: Array, // or String
			pretty: Boolean
		},
		convert: function(csv, options) {

			// default options object
			options = options || {}

			// get the rows
			var rows = csv.replace('\r', '').split('\n')

			// get the column headers either from an initial header row, or supplied explicitly
			var headers =
				_.isArray(options.headers) ? options.headers :
				(options.headers || rows.shift()).split(',')

			// convert each row to an object
			var objects = rows.map(function(row) {
				var values = row.split(',')
				return _.zipObject(headers, values)
			})

			// return proper stringified JSON
			return JSON.stringify(objects)
		}
	},

	/*******************************
	 * json-to-csv
	 *******************************/
	{
		from: 'json',
		to: 'csv',
		fromOptions: {
			headerRow: Boolean
		},
		convert: function(json, options) {

			// default options object
			options = options || {}

			// option defaults
			if(typeof options.headerRow === 'undefined') {
				options.headerRow = true;
			}

			// parse the JSON input
			var objects = JSON.parse(json)

			// get the column headers
			var headers = options.headerRow ? Object.keys(objects[0]) + '\n' : ''

			// convert each object to a row
			var joinRow = function(row) { return row.join(','); }
			var rows = objects.map(_.compose(joinRow, _.values))

			return headers + rows.join('\n')
		}
	}
]
