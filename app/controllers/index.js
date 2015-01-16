(function() {
  var convert;

  convert = require('./../convert.js');

  module.exports = {
    index: function(req, res) {
      return res.render('index');
    },
    convert: function(req, res) {
      var input;
      input = req.body.input;
      delete req.body.input;
      return res.send(200, convert(input, req.body));
    }
  };

}).call(this);
