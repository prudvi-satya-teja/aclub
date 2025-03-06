const express = require('express');
const router = express.Router();
const clubController = require('../controllers/paticipation_controller');

// to get club members
router.get('/get-club-members', clubController.getClubMembers);

module.exports= {
    router
}

