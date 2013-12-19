(function() {

  App.addInitializer(function(opts) {
    var appRouter = new App.routers.App();
    Backbone.history.start();
  });

  App.start();

})();
