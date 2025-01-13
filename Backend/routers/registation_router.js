const express = require('express');
const registrationController = require('../controllers/');

const router = express.Router();

//admin for specific club
// get all registered user
router.get('/registered-users',registrationController.getAllRegisteredUsers);

// users
// to regiseter for event
router.post('/register-event', registrationController.registerEvent);

// to give feedback (include rating is mandatory at the end of submission)
router.post('/give-feedback', registrationController.giveFeedback);

// get event feedback
router.get('/get-feedback', registrationController.getEventFeedback);

module.exports = {
    router
}

