(function() {
  var app, bodyParser, express, indexController, multer, server;

  express = require('express');

  bodyParser = require('body-parser');

  multer = require('multer');

  indexController = require('./controllers/index.js');

  require('newrelic');

  app = express();

  app.set('view engine', 'jade');

  app.set('views', __dirname + '/views');

  app.use(express["static"](__dirname + '/public'));

  app.use(bodyParser.urlencoded({
    extended: false
  }));

  app.use(multer({
    inMemory: true
  }));

  app.get('/', indexController.index);

  app.get(/^\/(.*)-to-(.*)/, indexController.index);

  app.post('/convert', indexController.convert);

  app.post('/upload', indexController.upload);

  server = app.listen(process.env.PORT || 9882, function() {
    return console.log('Express server listening on port ' + server.address().port);
  });

}).call(this);
