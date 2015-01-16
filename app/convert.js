(function() {
  var Promise;

  Promise = require('rsvp').Promise;

  module.exports = function(input, options) {
    return input.toString().toUpperCase() + '!!!';
  };

}).call(this);
