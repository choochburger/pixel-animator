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
      return res[0];
    });
  },

  findAll: function() {
    return db.query('SELECT * FROM users');
  },

  create: function(name) {
    var sql = 'INSERT INTO users (name) VALUES ($1) RETURNING *';
    return db.query(sql, [name]).then(function(res) {
      return res[0];
    });
  },

  createByService: function(serviceUserId, service, opts) {
    var firstName  = opts.firstName || 'Pat',
        lastName   = opts.lastName  || 'McNoname',
        avatar     = opts.avatar    || '/images/default_avatar.png',
        fullName   = firstName + ' ' + lastName;

    return users.create(fullName).then(function(user) {
      var sql  = 'INSERT INTO user_accounts ';
          sql += '(user_id, first_name, last_name, avatar, service, service_user_id) ';
          sql += 'VALUES ($1, $2, $3, $4, $5, $6) ';
          sql += 'RETURNING *';

      var params = [user.id,  firstName,  lastName, avatar, service, serviceUserId];

      return db.query(sql, params).then(function(res) {
        return res[0];
      });
    });
  }
};

module.exports = users;
