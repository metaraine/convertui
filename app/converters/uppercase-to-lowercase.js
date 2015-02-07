(function() {
  var convert;

  convert = function(input, options) {
    return input.toString().toLowerCase();
  };

  module.exports = {
    inputType: 'text',
    outputType: 'text',
    outputTypeVariation: 'lowercase',
    convert: convert
  };

}).call(this);
