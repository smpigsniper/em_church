let async = require('async');
let db = require('../config/db');
let jwt = require('../config/jwt');
let jsonResonse = require('./jsonResonse');
let schedules = {};

// `id` INT NOT NULL AUTO_INCREMENT,
// `date` DateTime NOT NULL,
// `title` VARCHAR(100) NOT NULL,
// `description` VARCHAR(255) NOT NULL,
// `charge` INT NOT NULL,

schedules.addSchedule = function (req, res, callback) {
    let date = req.body.date;
    let title = req.body.title;
    let description = req.body.description;
    let charge = req.body.charge;
    let data = {
        "date": date,
        "title": title,
        "description": description,
        "charge": charge,
    }
    db.insert("schedules", data, (err, result) => {
        if (err) {
            jsonResonse.sendResonse(res, 0, err.sqlMessage, null);
            return;
        } else {
            jsonResonse.sendResonse(res, 1, null, null);
            return;
        }
    });
}

schedules.getSchedule = function (req, res, callback) {
    let date = req.body.date;
    let data = {
        "date": date
    }
    getSchedule("*", data, "id", (err, result) => {
        if (err) {
            jsonResonse(res, 0, err.sqlMessage, null);
            return;
        } else {
            jsonResonse(res, 1, null, result);
            return;
        }
    });
}

schedules.editSchedule = function (req, res, callback) {
    let id = req.body.id;
    let date = req.body.date;
    let title = req.body.title;
    let description = req.body.description;
    let charge = req.body.charge;
    let update = {
        "date": date,
        "title": title,
        "description": description,
        "charge": charge,
    };
    let whereClause = {
        "id": id
    }
    let data = {
        "date": date,
    }

    let responseData = [];
    async.waterfall([
        function (next) {
            db.update("schedules", update, whereClause, (err, result) => {
                if (err) {
                    jsonResonse.sendResonse(res, 0, err, null);
                    return;
                } else {
                    next(null);
                }
            });
        },
        function (next) {
            getSchedule("*", data, "id", (err, result) => {
                if (err) {
                    jsonResonse(res, 0, err.sqlMessage, null);
                    return;
                } else {
                    responseData = result;
                    next(null);
                }
            });
        }
    ], function (err) {
        if (err) {
            jsonResonse.sendResonse(res, 0, err, null);
            return;
        } else {
            jsonResonse.sendResonse(res, 1, null, responseData);
            return;
        }
    });
}

schedules.deleteSchedule = function (req, res, callback) {
    let id = req.body.id;
    let date = req.body.date;
    let deleteData = {
        "id": id,
    }
    let data = {
        "date": date,
    }
    let responseData = [];
    async.waterfall([
        function (next) {
            db.delete("schedules", deleteData, (err, result) => {
                if (err) {
                    jsonResonse.sendResonse(res, 0, err, null);
                    return;
                } else {
                    next(null);
                }
            });
        },
        function (next) {
            getSchedule("*", data, "id", (err, result) => {
                if (err) {
                    jsonResonse(res, 0, err.sqlMessage, null);
                    return;
                } else {
                    responseData = result;
                    next(null);
                }
            });
        }
    ], function (err) {
        if (err) {
            jsonResonse.sendResonse(res, 0, err, null);
            return;
        } else {
            jsonResonse.sendResonse(res, 1, null, responseData);
            return;
        }
    });
}

function getSchedule(field, criteria, orderBy, callback) {
    db.getValue("vuSchedules", field, criteria, orderBy, (err, result) => {
        if (err) {
            callback(err.sqlMessage);
        } else {
            callback(null, result);
        }
    });
}

module.exports = schedules;