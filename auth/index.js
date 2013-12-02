var everyauth = require('everyauth'),
    EAPromise = require('everyauth/lib/promise'),
    models = require('../models'),
    users = models.users;

module.exports = function(config) {

  /**
   * All
   **/
  everyauth.everymodule
    .findUserById(function (req, userId, callback) {
      users.find(userId).done(function(user) {
        callback(null, user);
      });
    });

  /**
   * Google
   **/

  everyauth.google
    .appId(config.google.clientId)
    .appSecret(config.google.clientSecret)
    .scope('https://www.googleapis.com/auth/userinfo.profile https://www.google.com/m8/feeds/')
    .findOrCreateUser(function (session, accessToken, extra, googleUser) {
      var promise = new EAPromise(),
          serviceName = 'google';

      googleUser.refreshToken = extra.refresh_token;
      googleUser.expiresIn = extra.expires_in;

      users.findByService(googleUser.id, serviceName).then(function(user) {
        if (user) {
          promise.fulfill(user);
        } else {
          users.createByService(googleUser.id, serviceName, {
            firstName: googleUser.given_name,
            lastName:  googleUser.family_name,
            avatar:    googleUser.picture
          }).done(function(user) {
            promise.fulfill(user);
          });
        }
      });

      return promise;
    })
    .redirectPath('/');

  /**
   * Facebook
   **/

  everyauth.facebook
    .appId(config.facebook.appId)
    .appSecret(config.facebook.appSecret)
    .findOrCreateUser(function (session, accessToken, extra, fbUser) {
      var promise = new EAPromise(),
          serviceName = 'facebook';

      users.findByService(fbUser.id, serviceName).then(function(user) {
        if (user) {
          promise.fulfill(user);
        } else {
          users.createByService(fbUser.id, serviceName, {
            firstName: fbUser.first_name,
            lastName:  fbUser.last_name,
            avatar:    'http://graph.facebook.com/' + fbUser.username + '/picture?type=normal'
          }).done(function(user) {
            promise.fulfill(user);
          });
        }
      });

      return promise;
    })
    .redirectPath('/');

};
