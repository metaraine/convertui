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
        return res.send(200, value);
      });
    }
  };

}).call(this);
