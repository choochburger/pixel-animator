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
    expect($cell).toHaveClass(view.selectedClass);

    // Deselect
    $cell.trigger('mousedown');
    expect($cell).not.toHaveClass(view.selectedClass);
  });

  it('should require a title when saving', function() {
    spyOn(window, 'alert');
    view.save();
    expect(window.alert).toHaveBeenCalled();
  });

  it('should get selected cell data', function() {
    var $cells = view.$el.find('.animation_grid__cell');

    // Select first and last cells of the grid
    // Ex:
    //     X00
    //     000
    //     00X

    $cells.first().addClass(view.selectedClass);
    $cells.last().addClass(view.selectedClass);

    var data = view.getCellData(),
        numRows = data.length,
        numCols = data[0].length;

    expect(data[0][0]).not.toBe(-1);
    expect(data[numRows-1][numCols-1]).not.toBe(-1);
  });

  it('should trigger a save event with title and data', function() {
    var title = 'Test Title',
        numCells = view.$el.find('.animation_grid__cell').length;

    spyOn(view, 'getTitle').andReturn(title);

    view.on('save', function(e) {
      var numSavedCells = _.flatten(e.data).length;
      expect(e.title).toBe(title);
      expect(numSavedCells).toBe(numCells);
    }).save();
  });

});
