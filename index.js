const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
require("dotenv").config()

const app = express();
const { connectToDB } = require('./connections');
const { router: clubRouter } = require('./routers/club_router');

app.use(cors());
app.use(express.json());

connectToDB(process.env.MONGO_DB_URL)
    .then( () => {
        console.log('mongodb connected successfully');
    })
    .catch( (err) => {
        console.log('mongodb connection error');
    })

app.use('/', clubRouter);

const port = process.env.PORT || 5001
app.listen(port, () => {
    console.log(`server is running at port ${port}`);
})
