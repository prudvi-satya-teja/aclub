const express = require('express');
const registrationController = require('../controllers/registration_controllers');

const router = express.Router();
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');

// users who are logged in
// to regiseter for event
router.post('/register-event', authMiddleware.restrictToLoggedUserOnly, registrationController.registerEvent);

// to give feedback (include rating is mandatory at the end of submission)
router.post('/give-feedback',  registrationController.giveFeedback);


// get all registered user
router.get('/registered-users', registrationController.getAllRegisteredUsers);

// to check user registered or not
router.get('/registration-status',registrationController.registrationStatus);

// get event feedback
router.get('/get-feedback', registrationController.getEventFeedback);

//get average raing
router.get('/get-average-rating', registrationController.getAverageRating);

module.exports = {
    router
}

