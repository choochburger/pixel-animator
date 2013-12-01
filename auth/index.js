var everyauth = require('everyauth'),
    models = require('../models'),
    users = models.users;

module.exports = function(config) {

  /**
   * Google
   **/

  everyauth.google
    .appId(config.google.clientId)
    .appSecret(config.google.clientSecret)
    .scope('https://www.googleapis.com/auth/userinfo.profile https://www.google.com/m8/feeds/')
    .findOrCreateUser(function (sess, accessToken, extra, googleUser) {
      var serviceName = 'google';

      googleUser.refreshToken = extra.refresh_token;
      googleUser.expiresIn = extra.expires_in;

      return users.findByService(googleUser.id, serviceName).then(function(user) {
        if (user) {
          return user;
        } else {
           return users.createByService(googleUser.id, serviceName, {
             firstName: googleUser.given_name,
             lastName:  googleUser.family_name,
             avatar:    googleUser.link
           });
        }
      });
    })
    .redirectPath('/');

  /**
   * Facebook
   **/

  everyauth.facebook
    .appId(config.facebook.appId)
    .appSecret(config.facebook.appSecret)
    .findOrCreateUser(function (session, accessToken, accessTokenExtra, fbUser) {
      var serviceName = 'facebook';
      return users.findByService(fbUser.id, serviceName).then(function(user) {
        if (user) {
          return user;
        } else {
          return users.createByService(fbUser.id, serviceName, {
           firstName: fbUser.first_name,
           lastName:  fbUser.last_name,
           avatar:    'http://graph.facebook.com/' + fbUser.username + '/picture'
          });
        }
      });
    })
    .redirectPath('/');

};
