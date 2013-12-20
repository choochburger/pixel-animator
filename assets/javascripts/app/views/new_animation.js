(function() {

  App.views.NewAnimation = Marionette.ItemView.extend({
    template: App.templates['new_animation'],

    initialize: function() {
      _.bindAll(this, 'onMouseup');
    },

    events: {
      'mousedown .animation_grid__cell' : 'selectCell',
      'mouseover .animation_grid__cell' : 'onOverCell'
    },

    isMouseDown: false,
    isErasing:   false,

    selectedClass: 'animation_grid__cell--selected',

    selectCell: function(e) {
      var $cell = $(e.target);
      this.isMouseDown = true;
      this.isErasing = !$cell.hasClass(this.selectedClass);
      this.toggleCell($cell);
      $(document).on('mouseup', this.onMouseup);
    },

    onMouseup: function(e) {
      this.isMouseDown = false;
      $(document).off('mouseup', this.onMouseup);
    },

    onOverCell: function(e) {
      if (!this.isMouseDown) return;

      var $cell = $(e.target);
      this.toggleCell($cell);
    },

    toggleCell: function($cell) {
      if (!this.isErasing) {
        $cell.removeClass(this.selectedClass);
      } else {
        $cell.addClass(this.selectedClass);
      }
    }
  });

})();
