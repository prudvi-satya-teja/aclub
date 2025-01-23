const express = require('express');
const eventController = require('../controllers/event_controller');
const eventDataController = require('../controllers/event_data_controllers');

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
router.post('/create-event', uploadImage, eventController.createEvent);

// to update event
router.patch('/update-event', uploadImage, eventController.updateEvent);

// to delete event 
router.delete('/delete-event', eventController.deleteEvent);

module.exports = {
    router
}