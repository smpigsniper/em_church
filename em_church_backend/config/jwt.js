const jwt = require('jsonwebtoken');

let jwtToken = {};

jwtToken.generateAccessToken = function (email) {
    return jwt.sign(email, process.env.ACCESS_TOKEN_SECRET)
}

jwtToken.generateRefreshToken = function (email) {
    jwt.sign({ "email": email }, process.env.REFRESH_TOKEN_SECRET);
}

jwtToken.isAuthenticated = async function (req, res, next) {
    const token = req.body.token || req.query.token || req.headers["x-access-token"];
    if (!token) {
        return res.status(403).json({ "status": 0, "reason": "A token is required for authentication", "data": {} });
    }
    try {
        const decode = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
        req.username = decode;
    } catch (err) {
        return res.status(401).json({ "status": 0, "reason": err.message, "data": {} });
    }
    return next();
}

module.exports = jwtToken;