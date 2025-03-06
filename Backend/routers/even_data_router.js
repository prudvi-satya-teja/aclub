const express = require('express');
const eventDataController = require('../controllers/event_data_controllers');
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');
const router = express.Router();

const {upload} = require('../storage/storage');
const uploadImage = upload.single("clubImage");

// to upload image or images
router.post('/upload-images', authMiddleware.restrictToAdminOnly, uploadImage, eventDataController.uploadImage);

// to delete image or images
router.post('/delete-images', authMiddleware.restrictToAdminOnly, uploadImage, eventDataController.deleteImage);

// to update image
// router.post('/update-image', authMiddleware.restrictToAdminOnly, uploadImage, eventDataController.updateImage);

// to get all images
router.get('/get-all-images', eventDataController.getImages);

module.exports = {
    router
}