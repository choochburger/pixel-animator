var pg = require('pg'),
    Promise = require('promise'),
    dbPath = 'postgres://chrislyons@localhost/pixel_animator';

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
          resolve(result.rows);
        });
      });
    });

    return promise;
  }
}

module.exports = db;