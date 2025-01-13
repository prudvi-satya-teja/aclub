const express = require('express');
const eventDataController = require('../controllers/event_data_controllers');

const router = express.Router();

// to upload image or images
router.post('/upload-images', eventDataController.uploadImage);

// to upload video or videos
router.post('/upload-video', eventDataController.uploadVideo);

// to delete image or images
router.post('/delete-video', eventDataController.deleteImage);

// to delete video or videos
router.post('/delete-video', eventDataController.deleteImage);

// to update image
router.post('/update-image', eventDataController.updateImage);

//to update video
router.post('/update-video', eventDataController.updateVideo);

// to get all images
router.get('/get-all-images', eventDataController.getImages);

// to get all videos
router.get('/get-all-videos', eventDataController.getVideos);

module.exports = {
    router
}