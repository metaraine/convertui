(function() {
  var _, cint, concat2, converterModules, converters, fromTypes, requireDirectory, toTypes;

  cint = require('cint');

  _ = require('lodash');

  requireDirectory = require('require-directory');

  converterModules = requireDirectory(module, './converters');

  concat2 = cint.aritize(cint.inContext(Array.prototype.concat), 2);

  converters = _.reduce(converterModules, concat2);

  fromTypes = _(converters).pluck('from').sort().uniq(true).value();

  toTypes = _(converters).pluck('to').sort().uniq(true).value();

  module.exports = {
    getFromTypes: _.constant(fromTypes),
    getToTypes: _.constant(toTypes),
    getConverters: _.constant(converters),
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

}).call(this);
