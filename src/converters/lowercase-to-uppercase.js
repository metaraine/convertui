module.exports = {
	inputType: 'text',
	outputType: 'text',
	outputTypeVariation: 'uppercase',
	convert: function(input) {
		input.toString().toUpperCase();
	}
};
