const express = require('express');
const jwt = require('../config/jwt');
const router = express.Router();
let latest_news = require('../modules/latest_news');

router.post('/getLatestNews', jwt.isAuthenticated, latest_news.getLatestNews);

module.exports = router;