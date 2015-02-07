(function() {
  module.exports = function(converters) {
    return {
      findConverter: function(inputType, inputTypeVariation, outputType, outputTypeVariation) {
        var args, converter, name;
        args = arguments;
        if (arguments.length <= 2) {
          outputType = arguments[1];
        }
        for (name in converters) {
          converter = converters[name];
          if (inputType.match(converter.inputType) && outputType.match(converter.outputType) && (!inputTypeVariation || inputTypeVariation.match(converter.inputTypeVariation)) && (!outputTypeVariation || outputTypeVariation.match(converter.outputTypeVariation))) {
            return converter;
          }
        }
      }
    };
  };

}).call(this);
