(function() {

  App.controllers.App = Marionette.Controller.extend({
    showIndex: function() {
      console.log('index');
    },

    showAnimations: function() {
      console.log('animations');
    },

    showNewAnimation: function() {
      console.log('new animation');
    }
  });

})();
