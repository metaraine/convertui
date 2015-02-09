(function() {
  var conversionUtil, converters, fromTypes, requireDirectory, toTypes, _;

  _ = require('lodash');

  requireDirectory = require('require-directory');

  converters = requireDirectory(module, '../converters');

  conversionUtil = require('../conversion-util.js')(converters);

  fromTypes = _(converters).pluck('from').sort().uniq(true).value();

  toTypes = _(converters).pluck('to').sort().uniq(true).value();

  module.exports = {
    index: function(req, res) {
      return res.render('index', {
        converters: converters,
        fromTypes: fromTypes,
        toTypes: toTypes
      });
    },
    convert: function(req, res) {
      var from, input, promisedOutput, to;
      input = req.body.input;
      from = req.body.from;
      to = req.body.to;
      promisedOutput = new Promise(function(resolve, reject) {
        var converter;
        converter = conversionUtil.findConverter(from, to);
        if (converter) {
          return resolve(converter.convert(input));
        } else {
          throw new Error("Converter not defined for " + from + "-to-" + to);
        }
      });
      return promisedOutput.then(function(value) {
        return res.send(value);
      }, function(error) {
        console.error(error.stack);
        return res.status(500);
      });
    },
    upload: function(req, res) {
      var promisedOutput;
      promisedOutput = new Promise(function(resolve, reject) {
        var fileInfo, name, _ref, _results;
        _ref = req.files;
        _results = [];
        for (name in _ref) {
          fileInfo = _ref[name];
          _results.push(resolve(convert(fileInfo.buffer)));
        }
        return _results;
      });
      return promisedOutput.then(function(value) {
        return res.send({
          success: true,
          output: value
        });
      });
    }
  };

}).call(this);
