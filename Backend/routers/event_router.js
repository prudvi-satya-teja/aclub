const express = require('express');
const eventController = require('../controllers/event_controller');

const router = express.Router();

// admin
// to create event
router.post('/create-event', eventController.createEvent);

// to update event
router.patch('/update-event', eventController.updateEvent);

// to delete event 
router.delete('/delete-event', eventController.deleteEvent);


module.exports = {
    router
}