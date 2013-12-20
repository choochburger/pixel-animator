describe('New Animation', function() {

  var view;

  beforeEach(function() {
    view = new App.views.NewAnimation();
    view.render();
  });

  afterEach(function() {
    view = null;
  });

  it('should toggle grid cells', function() {
    var $cell = view.$el.find('.animation_grid__cell').first();

    // Select
    $cell.trigger('mousedown');
    expect($cell.hasClass(view.selectedClass)).toBe(true);

    // Deselect
    $cell.trigger('mousedown');
    expect($cell.hasClass(view.selectedClass)).toBe(false);
  });

});
