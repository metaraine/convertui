(function() {
  var convert;

  convert = require('./../convert.js');

  module.exports = {
    index: function(req, res) {
      return res.render('index');
    },
    convert: function(req, res) {
      var input, promisedOutput;
      input = req.body.input;
      delete req.body.input;
      promisedOutput = new Promise(function(resolve, reject) {
        return resolve(convert(input, req.body));
      });
      return promisedOutput.then(function(value) {
        return res.send(value);
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
