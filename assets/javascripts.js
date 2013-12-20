module.exports = {

  development: [
    '/javascripts/lib/jquery.js',
    '/javascripts/lib/prefixfree.js',
    '/javascripts/lib/handlebars.runtime.js',
    '/javascripts/lib/bootstrap.js',
    '/javascripts/lib/underscore.js',
    '/javascripts/lib/backbone.js',
    '/javascripts/lib/backbone.babysitter.js',
    '/javascripts/lib/backbone.wreqr.js',
    '/javascripts/lib/backbone.marionette.js',
    '/javascripts/app/app.js',
    '/javascripts/app/templates.js',
    '/javascripts/app/controllers/app.js',
    '/javascripts/app/routers/app.js',
    '/javascripts/app/views/index.js',
    '/javascripts/app/views/animations.js',
    '/javascripts/app/views/new_animation.js',
    '/javascripts/app/init.js',
  ],

  production: [
    '/javascripts/app.concat.js'
  ]

};
