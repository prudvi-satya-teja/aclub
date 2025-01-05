const express = require('express');
const {} = require('../controllers/event_controller');

const router = express.Router();

// admin
// to create event
router.post('/create-event', handleCreateEvent);

// to update event
router.patch('/update-event', handleUpdateEvent);

// to delete event 
router.delete('/delete-event', handleDeleteEvent);

// get all registered user
router.get('/registered-users', handleRegisteredUsers);

// get event feedback
router.get('/event-feedback', handleGetEventFeedback);

// users
// user regiseter for event
router.post('/register-event', handleRegisterEvent);

// add feedback
router.post('/add-feedback', handleAddFeedback);

module.exports = {
    handleCreateEvent,
    handleDeleteEvent,
    handleUpdateEvent,
    handleRegisteredUsers,
    handleGetEventFeedback,
    handleRegisterEvent,
    handleAddFeedback
}