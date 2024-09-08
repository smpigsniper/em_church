const express = require('express');
const jwt = require('../config/jwt');
const router = express.Router();
let schedule = require('../modules/schedule');

router.post('/getSchedule', jwt.isAuthenticated, schedule.getSchedule);
router.post('/', jwt.isAuthenticated, schedule.addSchedule);
router.put('', jwt.isAuthenticated, schedule.editSchedule);
router.delete('', jwt.isAuthenticated, schedule.deleteSchedule);
module.exports = router;