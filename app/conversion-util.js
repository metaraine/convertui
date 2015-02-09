(function() {
  module.exports = function(converters) {
    return {
      findConverter: function(from, to) {
        var converter, name;
        if (!from) {
          throw new Error("Must specify a \"from\" type. Received " + from + ".");
        } else if (!to) {
          throw new Error("Must specify a \"to\" type. Received " + to + ".");
        }
        for (name in converters) {
          converter = converters[name];
          if (from.match(converter.from) && to.match(converter.to)) {
            return converter;
          }
        }
      }
    };
  };

}).call(this);
