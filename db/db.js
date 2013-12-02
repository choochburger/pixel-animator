var pg = require('pg'),
    Promise = require('promise'),
    dbPath = process.env.DATABASE_URL || 'postgres://chrislyons@localhost/pixel_animator';

var db = {
  query: function(sql, params) {
    params = params || [];

    var promise = new Promise(function(resolve, reject) {
      pg.connect(dbPath, function(err, client, done) {
        if (err) {
          var msg = 'could not connect to postgres';
          reject(msg);
          return console.error(msg, err);
        }

        client.query(sql, params, function(err, result) {
          done();
          if (err) {
            var msg = 'error running query';
            reject(msg);
            return console.error(msg, err);
          }

          var rows = result.rows;
          if (rows.length > 1) resolve(rows);
          else resolve(rows[0]);
        });
      });
    });

    return promise;
  }
}

module.exports = db;
