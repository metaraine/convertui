module.exports = {
	inputType: 'text',
	outputType: 'text',
	outputTypeVariation: 'lowercase',
	convert: function(input) {
		input.toString().toLowerCase();
	}
};
