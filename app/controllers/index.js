(function() {
  var conversionUtil, converters, requireDirectory;

  requireDirectory = require('require-directory');

  converters = requireDirectory(module, '../converters');

  conversionUtil = require('../conversion-util.js')(converters);

  module.exports = {
    index: function(req, res) {
      return res.render('index', {
        converters: converters
      });
    },
    convert: function(req, res) {
      var input, inputType, inputTypeVariation, outputType, outputTypeVariation, promisedOutput;
      input = req.body.input;
      inputType = req.body.inputType;
      outputType = req.body.outputType;
      inputTypeVariation = req.body.inputTypeVariation;
      outputTypeVariation = req.body.outputTypeVariation;
      promisedOutput = new Promise(function(resolve, reject) {
        var converter;
        converter = conversionUtil.findConverter(inputType, inputTypeVariation, outputType, outputTypeVariation);
        if (converter) {
          return resolve(converter.convert(input));
        } else {
          throw new Error("Converter not defined for inputType: " + inputType + ", inputTypeVariation: " + inputTypeVariation + ", outputType: " + outputType + ", outputTypeVariation: " + outputTypeVariation);
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
