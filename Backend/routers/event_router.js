const express = require('express');
const eventController = require('../controllers/event_controller');
const eventDataController = require('../controllers/event_data_controllers');
const authMiddleware = require('../middlewares/authentication_middleware');

const router = express.Router();

const multer = require('multer');
const path = require('path');
const fs = require('fs');

const imagePath = path.join(__dirname, '..', 'public', 'events_data');

if(!fs.existsSync(imagePath)) {
    fs.mkdirSync(imagePath, {recursive: true});
}

const demoStorage = multer.diskStorage({
    destination: function(req, file, cb) {
        console.log("imagePath : ", imagePath);
        cb(null, imagePath);
    },
    filename: function(req, file, cb) {
        console.log("filename: ", file.originalname);
        cb(null, file.originalname);
    }
})

const uploadImage = multer({storage: demoStorage}).single("eventImage");

// admin
// to create event
router.post('/create-event',  uploadImage, eventController.createEvent);

// to update event
router.patch('/update-event', uploadImage, eventController.updateEvent);

// to delete event 
router.delete('/delete-event', eventController.deleteEvent);

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

router.get('/get-event-details', eventController.getEventDetails);

module.exports = {
    router
}