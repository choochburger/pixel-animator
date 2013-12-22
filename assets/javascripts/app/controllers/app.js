(function() {

  App.controllers.App = Marionette.Controller.extend({
    showView: function(name, View, Controller) {
      var viewName = name + 'View';

      App[viewName] = App[viewName] || new View();

      // Controller is optional
      if (Controller) {
        var controllerName = name + 'Controller';
        App[controllerName] = App[controllerName] || new Controller({
          view: App[viewName]
        });
      }

      App.mainRegion.show(App[viewName]);
    },

    showIndex: function() {
      this.showView('index', App.views.Index);
    },

    showAnimations: function() {
      this.showView('animations', App.views.Animations);
    },

    showNewAnimation: function() {
      this.showView('newAnimation', App.views.NewAnimation, App.controllers.NewAnimation);
    }
  });

})();
