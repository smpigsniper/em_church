const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const userRouter = require('./router/user');
const scheduleRouter = require('./router/schedule');
const dotenv = require('dotenv');

dotenv.config();

const port = process.env.PORT || 8081;

app.use(cors());
app.use(express.urlencoded({ extended: true })); // Built-in middleware for URL-encoded bodies
app.use(express.json()); // Built-in middleware for JSON bodies

// Routes
app.use('/api/users', userRouter);
app.use('/api/schedule', scheduleRouter);

// Catch 404 errors and forward to error handler
app.use((req, res, next) => {
    const err = new Error('404 Not Found');
    err.status = 404;
    next(err);
});

// General error handler
app.use((err, req, res, next) => {
    console.error(err.stack); // Log the stack trace for debugging
    res.status(err.status || 500).send({
        status: err.status || 500,
        message: err.message
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Listening on port ${port} ...`);
});
