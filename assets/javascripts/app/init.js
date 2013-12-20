(function() {

  App.addInitializer(function(opts) {
    var appRouter = new App.routers.App();
    Backbone.history.start();
  });

  App.addRegions({
    mainRegion: '.main'
  });

  App.start();

})();
