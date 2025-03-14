const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
require("dotenv").config()

const app = express();

const { connectToDB } = require('./connections');
const { router: clubRouter } = require('./routers/club_router');
const { router: userRouter} = require('./routers/user_router');
const { router: eventRouter } = require('./routers/event_router');
const { router: registrationRouter } = require('./routers/registation_router');
const { router: eventDataRouter } = require('./routers/even_data_router');
const { router: participationRouter } = require('./routers/participation_router');
const { router: authenticationRouter } = require('./routers/authentication_router');

const authMiddleware = require('./middlewares/authentication_authorizarization_middleware');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


connectToDB(process.env.MONGO_DB_URL)
    .then( () => { console.log('mongodb connected successfully'); })
    .catch( (err) => { console.log('mongodb connection error'); })

app.use('/clubs', clubRouter);

app.use('/events', eventRouter);

app.use('/data', eventDataRouter);

app.use('/users', userRouter);

app.use('/registrations', registrationRouter);

app.use('/participation', participationRouter);

app.use('/auth', authenticationRouter);

setInterval(() => {
    try {
        fetch('https://aclub.onrender.com'); 
    }
    catch(e) {
    }
}, 840000);

 
const port = process.env.PORT || 5001

app.listen(port, () => {
    console.log(`server is running at port ${port}`);
})


