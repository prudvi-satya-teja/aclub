const express = require('express');
const router = express.Router();
const userController = require('../controllers/user_controllers');
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');

// admin for a specific club 
// to add user
router.post('/add-user', authMiddleware.restrictToAdminOnly, userController.addUser);

// to delete user
router.delete('/delete-user', authMiddleware.restrictToAdminOnly, userController.deleteUser);

// to update user
router.patch('/update-user', authMiddleware.restrictToAdminOnly, userController.updateUser);


// for all
// to get user details
router.get('/user-details',authMiddleware.restrictToLoggedUserOnly, userController.getUserDetails);

// to get all user in a specific club
router.get('/get-all-users',  userController.getAllUsers);

module.exports = {
    router
}

