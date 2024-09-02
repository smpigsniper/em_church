const express = require('express');
const router = express.Router();
let user = require('../modules/user')
require('dotenv').config();

router.get('/test', user.test);
router.post('/register', user.register);
router.post('/login', user.login);

module.exports = router;