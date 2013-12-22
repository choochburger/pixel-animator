(function() {

  App.controllers.NewAnimation = Marionette.Controller.extend({

    initialize: function(opts) {
      var view = opts.view;
      view.on('save', this.save);
    },

    save: function(data) {
      $.post('/animations/new', data);
    }

  });

})();
