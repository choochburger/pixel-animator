var db = require('../db/db.js');

var animations = {
  create: function(req, res) {
    var body  = req.body;

    var sql  = 'INSERT INTO user_animations ';
        sql += '(user_id, title, data) ';
        sql += 'VALUES ($1, $2, $3) ';
        sql += 'RETURNING *';

    db
      .query(sql, [req.user.id, body.title, body.data])
      .then(function(animation) {
        res.send(animation);
      }, function(err) {
        res.send(500, err);
      });
  }
};

module.exports = animations;
