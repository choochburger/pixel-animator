var db = require('../db/db.js');

var users = {
  find: function(id) {
    return db.query('SELECT * FROM users WHERE id=$1', [id]);
  },

  findByService: function(id, service) {
    var sql  = 'SELECT * from users ';
        sql += 'WHERE service_user_id=$1 ';
        sql += 'AND service=$2';

    return db.query(sql, [id, service]);
  },

  createByService: function(serviceUserId, service, opts) {
    var firstName = opts.firstName || 'Pat',
        lastName  = opts.lastName  || 'McNoname',
        avatar    = opts.avatar    || '/images/default_avatar.png';

    var sql  = 'INSERT INTO users ';
        sql += '(first_name, last_name, avatar, service, service_user_id) ';
        sql += 'VALUES ($1, $2, $3, $4, $5) ';
        sql += 'RETURNING *';

    var params = [firstName, lastName, avatar, service, serviceUserId];

    return db.query(sql, params);
  }
};

module.exports = users;
