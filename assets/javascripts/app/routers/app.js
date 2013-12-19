(function() {

  App.routers.App = Marionette.AppRouter.extend({
    controller: new App.controllers.App,
    appRoutes: {
      '':               'showIndex',
      'animations':     'showAnimations',
      'animations/new': 'showNewAnimation'
    }
  });

})();
