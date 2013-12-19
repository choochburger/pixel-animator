module.exports = {

  development: [
    '/javascripts/lib/jquery.js',
    '/javascripts/lib/bootstrap.js',
    '/javascripts/lib/underscore.js',
    '/javascripts/lib/backbone.js',
    '/javascripts/lib/backbone.babysitter.js',
    '/javascripts/lib/backbone.wreqr.js',
    '/javascripts/lib/backbone.marionette.js',

    '/javascripts/app/app.js',
    '/javascripts/app/controllers/app.js',
    '/javascripts/app/routers/app.js',
    '/javascripts/app/init.js',
  ],

  production: [
    '/javascripts/app.concat.js'
  ]

};
