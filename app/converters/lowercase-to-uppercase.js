module.exports = {
	inputType: 'text',
	outputType: 'text',
	outputTypeVariation: 'uppercase',
	convert: function(input) {
		return input.toString().toUpperCase();
	}
};
