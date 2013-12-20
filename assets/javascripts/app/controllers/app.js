(function() {

  App.controllers.App = Marionette.Controller.extend({
    showIndex: function() {
      App.indexView = App.indexView || new App.views.Index();
      App.mainRegion.show(App.indexView);
    },

    showAnimations: function() {
      App.animationsView = App.newAnimationsView || new App.views.Animations();
      App.mainRegion.show(App.animationsView);
    },

    showNewAnimation: function() {
      App.newAnimationView = App.newAnimationView || new App.views.NewAnimation();
      App.mainRegion.show(App.newAnimationView);
    }
  });

})();
