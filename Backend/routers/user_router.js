const express = require('express');
const router = express.Router();
const userController = require('../controllers/user_controllers');

// admin for a specific club 
// to add user
router.post('/add-user', userController.addUser);

// to get user details
router.get('/user-details', userController.getUserDetails);

// to delete user
router.delete('/delete-user', userController.deleteUser);

// to update user
router.patch('/update-user', userController.updateUser);

// to get all user in a specific club
router.get('/get-all-users', userController.getAllUsers);

module.exports = {
    router
}

