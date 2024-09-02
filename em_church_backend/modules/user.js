let async = require('async');
let encrypted = require('../config/encrypt');
let db = require('../config/db');
let jwt = require('../config/jwt');
let jsonResonse = require('./jsonResonse');
let user = {};

user.test = function (req, res, next) {
    res.send('test')
}

user.register = async function (req, res, next) {
    let email = req.body.email;
    let password = req.body.password;
    let prefer_name = req.body.prefer_name;
    let tel = req.body.tel;
    let hashedPassword = await encrypted.hashPassword(password);
    let data = {
        "email": email,
        "password": hashedPassword,
        "prefer_name": prefer_name,
        "tel": tel
    }
    db.insert("users", data, (err, result) => {
        if (err) {
            jsonResonse.sendResonse(res, 0, err.sqlMessage, null);
            return;
        } else {
            jsonResonse.sendResonse(res, 1, null, null);
            return;
        }
    });
}

user.login = function (req, res, next) {
    let email = req.body.email;
    let password = req.body.password;
    let data = {
        "email": email
    }
    db.getValue("users", "*", data, null, async (err, result) => {
        if (err) {
            jsonResonse.sendResonse(res, 0, err.sqlMessage, null);
            return;
        } else {
            if (result.length > 0) {
                if (await encrypted.comparePassword(password, result[0].password)) {
                    let data = {
                        "email": email,
                        "date": Date(),
                    }
                    let token = jwt.generateAccessToken(data);
                    let responseData = result[0];
                    delete responseData.password;
                    responseData.accessToken = token;
                    jsonResonse.sendResonse(res, 1, null, responseData);
                    return;
                } else {
                    jsonResonse.sendResonse(res, 0, "Email or Password incorrect!", null);
                    return;
                }
            } else {
                jsonResonse.sendResonse(res, 0, "Email or Password incorrect!", null);
                return;
            }
        }
    });
}

user.refreshToken = function (req, res, callback) {
    try {
        const token = jwt.generateRefreshToken(req.body.email);
        jsonResonse.sendResonse(res, 1, null, { "email": req.body.email, "accessToken": token });
        return
    } catch (err) {
        jsonResonse.sendResonse(res, 0, err.message, null);
        return;
    }
}

module.exports = user;