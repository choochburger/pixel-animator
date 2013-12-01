var db = require('../db/db.js');

var users = {
  find: function(id) {
    var user = db.query('SELECT * FROM users WHERE id=$1', [id]);
    return user.then(function(res) {
      return res[0];
    });
  },

  findAll: function() {
    return db.query('SELECT * FROM users');
  }
};

module.exports = users;
