const express = require('express');
const clubController = require('../controllers/club_controller');
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');

const router = express.Router();

const {upload} = require('../storage/storage');
const uploadImage = upload.single("clubImage");

// create club
router.post('/create-club', authMiddleware.restrictToAdminOnly, uploadImage, clubController.createClub);

// update club
router.patch('/update-club', authMiddleware.restrictToAdminOnly, uploadImage, clubController.updateClub);

// delete club
router.delete('/delete-club', authMiddleware.restrictToAdminOnly, clubController.deleteClub);

// get all clubs
router.get('/get-all-clubs', clubController.getAllClubs);


module.exports = {
    router
}




