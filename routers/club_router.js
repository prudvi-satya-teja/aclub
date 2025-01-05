const express = require('express');
const clubController = require('../controllers/club_controller');

const router = express.Router();

const multer = require('multer');
const path = require('path');
const fs = require('fs');

const imagePath = path.join(__dirname, '..', 'public', 'images');

if(!fs.existsSync(imagePath)) {
    fs.mkdirSync(imagePath, {recursive: true});
}

const demoStorage = multer.diskStorage({
    destination: function(req, file, cb) {
        console.log("imagepath", imagePath);
        cb(null, imagePath);
    },
    filename: function(req, file, cb) {
        console.log("filename", file.originalname);
        cb(null, file.originalname);
    }
})

const uploadImage = multer({storage: demoStorage}).single("clubImage");

// create club
router.post('/create-club', uploadImage, clubController.handleCreateClub);

// update club
router.patch('/update-club', clubController.handleUpdateClub);

// delete club
router.delete('/delete-club', clubController.handleDeleteClub);

// get all clubs
router.get('/get-all-clubs', clubController.handleGetAllClubs);


module.exports = {
    router
}




