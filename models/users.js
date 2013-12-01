var db = require('../db/db.js');

var users = {
  find: function(id) {
    var user = db.query('SELECT * FROM users WHERE id=$1', [id]);
    return user.then(function(res) {
      return res[0];
    });
  },

  findByService: function(id, service) {
    var sql  = 'SELECT * from user_accounts ';
        sql += 'WHERE service_user_id=$1 ';
        sql += 'AND service=$2';

    return db.query(sql, [id, service]).then(function(res) {
      var userAccount = res[0];
      return userAccount;
    }).then(function(userAccount) {
      if (!userAccount) return undefined;
      return users.find(userAccount.user_id);
    });
  },

  findAll: function() {
    return db.query('SELECT * FROM users');
  },

  createByService: function(id, service) {
    console.log('creating... (not implemented)');
    return false;
  }
};

module.exports = users;
