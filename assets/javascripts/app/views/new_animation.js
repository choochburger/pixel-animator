(function() {

  App.views.NewAnimation = Marionette.ItemView.extend({
    template: App.templates['new_animation'],

    initialize: function() {
      _.bindAll(this, 'onMouseup');
    },

    events: {
      'mousedown .animation_grid__cell' : 'selectCell',
      'mouseover .animation_grid__cell' : 'onOverCell',
      'click .animation_grid__save_btn' : 'save'
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
    },

    getTitle: function() {
      return this.$el.find('.animation_title').val();
    },

    getCellData: function() {
      var self = this, data = [];

      this.$el.find('.animation_grid__row').each(function() {
        var $row = $(this),
            rowData = [];

        $row.find('.animation_grid__cell').each(function() {
          var $cell = $(this);
          if ($cell.hasClass(self.selectedClass)) {
            rowData.push($cell.css('background-color'));
          } else {
            rowData.push(-1);
          }
        });

        data.push(rowData);
      });

      return data;
    },

    save: function(e) {
      var title = this.getTitle(),
          data;

      if (!title || !title.length) {
        return alert('Please enter a title');
      }

      data = this.getCellData();

      // this.controller.save(title, data);
    }
  });

})();
