module.exports = {
	inputType: 'text',
	outputType: 'text',
	outputTypeVariation: 'lowercase',
	convert: function(input) {
		return input.toString().toLowerCase();;
	}
};
