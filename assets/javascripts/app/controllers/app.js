(function() {

  App.controllers.App = Marionette.Controller.extend({
    showView: function(viewName, View) {
      App[viewName] = App[viewName] || new View();
      App.mainRegion.show(App[viewName]);
    },

    showIndex: function() {
      this.showView('indexView', App.views.Index);
    },

    showAnimations: function() {
      this.showView('animationsView', App.views.Animations);
    },

    showNewAnimation: function() {
      this.showView('newAnimationView', App.views.NewAnimation);
    }
  });

})();
