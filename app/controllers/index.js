(function() {
  var _, conversion;

  _ = require('lodash');

  conversion = require('../conversion.js');

  module.exports = {
    index: function(req, res) {
      return res.render('index', {
        converters: conversion.getConverters(),
        fromTypes: conversion.getFromTypes(),
        toTypes: conversion.getToTypes(),
        from: req.params[0],
        to: req.params[1]
      });
    },
    convert: function(req, res) {
      var from, input, options, promisedOutput, to;
      input = req.body.input;
      from = req.body.from;
      to = req.body.to;
      options = {};
      promisedOutput = new Promise(function(resolve, reject) {
        var converter;
        if (!from) {
          return reject("No 'from' type specified");
        } else if (!to) {
          return reject("No 'to' type specified");
        }
        converter = conversion.findConverter(from, to);
        if (!converter) {
          return reject("Converter not defined for " + from + "-to-" + to);
        }
        return resolve(converter.convert(input, options));
      });
      return promisedOutput.then(function(value) {
        return res.send(value);
      }, function(error) {
        console.error(error, error.stack);
        return res.status(500).send(error);
      });
    },
    upload: function(req, res) {
      var options, promisedOutput;
      options = {};
      promisedOutput = new Promise(function(resolve, reject) {
        var fileInfo, name, ref, results;
        ref = req.files;
        results = [];
        for (name in ref) {
          fileInfo = ref[name];
          results.push(resolve(convert(fileInfo.buffer, options)));
        }
        return results;
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
