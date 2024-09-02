const express = require('express');
const jwt = require('../config/jwt');
const router = express.Router();
let schedule = require('../modules/schedule');

router.get('/schedule', jwt.isAuthenticated, schedule.getSchedule);
router.post('/schedule', jwt.isAuthenticated, schedule.addSchedule);
router.put('/schedule', jwt.isAuthenticated, schedule.editSchedule);
router.delete('/schedule', jwt.isAuthenticated, schedule.deleteSchedule);
module.exports = router;