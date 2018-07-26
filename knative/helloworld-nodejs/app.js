// 
// From https://github.com/knative/docs/blob/master/serving/samples/helloworld-nodejs/README.md
// 
const express = require('express');
const app = express();

app.get('/', function (req, res) {
  console.log('Hello world received a request.');

  var target = process.env.TARGET || 'NOT SPECIFIED';
  res.send('Hello world: ' + target);
});

app.get('/version', function (req, res) {
  var version = process.env.APP_VERSION || 'NOT SPECIFIED';
  res.send('Version: ' + version);
});

var port = 8080;
app.listen(port, function () {
  console.log('Hello world listening on port',  port);
});