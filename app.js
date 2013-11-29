
/**
 * Module dependencies.
 */

var everyauth = require('everyauth'),
    express = require('express'),
    routes = require('./routes'),
    user = require('./routes/user'),
    http = require('http'),
    path = require('path'),
    pg = require('pg'),
    config = require('./config');

var app = express();

/**
 * Postgres
 **/

var db = 'postgres://chrislyons@localhost/pixel_animator';
var client = new pg.Client(db);

client.connect(function(err) {
  if (err) {
    return console.error('could not connect to postgres', err);
  }
  client.query('SELECT * FROM users', function(err, result) {
    console.log(result.rows);
    if (err) {
      return console.error('error running query', err);
    }
    //output: Tue Jan 15 2013 19:12:47 GMT-600 (CST)
    client.end();
  });
});

/**
 * Auth
 **/

everyauth.debug = true;

everyauth.google
  .appId(config.google.clientId)
  .appSecret(config.google.clientSecret)
  .scope('https://www.googleapis.com/auth/userinfo.profile https://www.google.com/m8/feeds/')
  .findOrCreateUser(function (sess, accessToken, extra, googleUser) {
    googleUser.refreshToken = extra.refresh_token;
    googleUser.expiresIn = extra.expires_in;
    return googleUser;
  })
  .redirectPath('/');

// all environments
app
  .set('port', process.env.PORT || 3000)
  .set('views', __dirname + '/views')
  .set('view engine', 'jade')
  .use(express.favicon())
  .use(express.logger('dev'))
  .use(express.bodyParser())
  .use(express.methodOverride())
  .use(express.cookieParser(config.cookieSecret))
  .use(express.session())
  .use(everyauth.middleware(app))
  .use(app.router)
  .use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/users', user.list);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
