const express = require('express');
const eventController = require('../controllers/event_controller');
const eventDataController = require('../controllers/event_data_controllers');
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');
require("dotenv").config();

const router = express.Router();

const {upload} = require('../storage/storage');
const uploadImage = upload.single("eventImage");

// admin
// to create event
router.post('/create-event', authMiddleware.restrictToAdminOnly, uploadImage ,eventController.createEvent);

// to update event
router.patch('/update-event', authMiddleware.restrictToAdminOnly, uploadImage, eventController.updateEvent);

// to delete event 
router.delete('/delete-event', authMiddleware.restrictToAdminOnly, eventController.deleteEvent);

// for all
// to get all - events
router.post('/get-all-events', eventController.getAllEvents);

// to get ongoing events for a specific club
router.get('/ongoing-events', eventController.getOngoingEvents);

// to get upcoming events for a specific club
router.get('/upcoming-events', eventController.getUpcomingEvents);

// to get past event for a specific club
router.get('/past-events', eventController.getPastEvents);

// to get  all ongoing events 
router.get('/all-ongoing-events', eventController.getAllOngoingEvents);

// to get all upcoming events
router.get('/all-upcoming-events', eventController.getAllUpcomingEvents);

// to get all past event
router.get('/all-past-events', eventController.getAllPastEvents);

// to get event details
router.get('/get-event-details', eventController.getEventDetails);

module.exports = {
    router
}
