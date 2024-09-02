let jsonResonse = {}

jsonResonse.sendResonse = function (res, status, reason, data) {
    res.json({ "status": status, "reason": reason, "data": data });
}

module.exports = jsonResonse;