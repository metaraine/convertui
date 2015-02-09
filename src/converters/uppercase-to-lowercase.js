module.exports = {
	from: 'text',
	to: 'lowercase',
	convert: function(input) {
		return input.toString().toLowerCase();;
	}
};
