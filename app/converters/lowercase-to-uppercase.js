(function() {
  var convert;

  convert = function(input, options) {
    return input.toString().toUpperCase();
  };

  module.exports = {
    inputType: 'text',
    outputType: 'text',
    outputTypeVariation: 'uppercase',
    convert: convert
  };

}).call(this);
