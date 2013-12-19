
/*
 * GET home page.
 */

exports.index = function(req, res) {
  var env = process.env.NODE_ENV || 'development';
  res.render('index', {
    title: 'Pixel Animator',
    javascripts: require('../assets/javascripts')[env]
  });
};
