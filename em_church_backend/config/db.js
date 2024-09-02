let mysql = require('mysql2');

let db = {}

db.createConnection = function () {
    let connection = mysql.createConnection({
        host: 'localhost',
        database: 'EM_Church',
        user: 'root',
        password: 'Abcd1234'
    });
    return connection;
}

db.insert = function (table, data, callback) {
    let connection = this.createConnection();
    connection.connect();
    let columns = Object.keys(data).join(', ');
    let placeholders = Object.keys(data).map(() => '?').join(', ');
    let values = Object.values(data);
    let sql = `INSERT INTO ${table} (${columns}) VALUES (${placeholders})`;
    connection.query(sql, values, (err, results) => {
        console.log(sql);
        console.log(values);
        if (err) {
            callback(err);
        } else {
            callback(null, results);
        }
        connection.end();
    });
}

db.getValue = function (table, field, criteria, orderBy, callback) {
    let connection = this.createConnection();
    connection.connect();
    let whereClause = Object.keys(criteria).map(key => `${key} = ?`).join(' AND ');
    let values = Object.values(criteria);
    let sql = `SELECT ${field} FROM ${table} WHERE ${whereClause}`;
    if (orderBy) {
        sql += ` ORDER BY ${orderBy}`;
    }
    connection.query(sql, values, (err, results) => {
        console.log(sql);
        console.log(values);
        if (err) {
            callback(err);
        } else {
            callback(null, results);
        }
        connection.end();
    });
}

db.update = function (table, updates, criteria, callback) {
    let connection = this.createConnection();
    connection.connect();
    let setClause = Object.keys(updates).map(key => `${key} = ?`).join(', ');
    let updateValues = Object.values(updates);
    let whereClause = Object.keys(criteria).map(key => `${key} = ?`).join(' AND ');
    let criteriaValues = Object.values(criteria);
    let values = updateValues.concat(criteriaValues);
    let sql = `UPDATE ${table} SET ${setClause} WHERE ${whereClause}`;

    connection.query(sql, values, (err, results) => {
        console.log(sql);
        console.log(values);
        if (err) {
            callback(err);
        } else {
            callback(null, results);
        }
        connection.end();
    });
};

db.delete = function (table, criteria, callback) {
    let connection = this.createConnection();
    connection.connect();
    let whereClause = Object.keys(criteria).map(key => `${key} = ?`).join(' AND ');
    let values = Object.values(criteria);
    let sql = `DELETE FROM ${table} WHERE ${whereClause}`;

    connection.query(sql, values, (err, results) => {
        console.log(sql);
        console.log(values);
        if (err) {
            callback(err);
        } else {
            callback(null, results);
        }
        connection.end();
    });
}



module.exports = db;