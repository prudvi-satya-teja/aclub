const express = require('express');
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

const uplaodImages = multer({storage: demoStorage}).array("eventImages");

// to upload image or images
router.post('/upload-images', authMiddleware.restrictToAdminOnly, uplaodImages, eventDataController.uploadImage);

// to delete image or images
router.post('/delete-images', authMiddleware.restrictToAdminOnly, uplaodImages, eventDataController.deleteImage);

// to update image
// router.post('/update-image', uplaodImages, eventDataController.updateImage);

// to get all images
router.get('/get-all-images', eventDataController.getImages);

module.exports = {
    router
}