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
      googleUser.refreshToken = extra.refresh_token;
      googleUser.expiresIn = extra.expires_in;

      return users.findByService(googleUser.id, 'google').then(function(user) {
        if (user) {
          return user;
        } else {
           return users.createByService(googleUser.id, 'google', {
             firstName: googleUser.given_name,
             lastName:  googleUser.family_name,
             avatar:    googleUser.link
           });
        }
      });
    })
    .redirectPath('/');

};
