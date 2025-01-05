const express = require('express');

const router = express.Router();

// admin
// to add user
router.post('/add-user', handleAddUser);

// to get user details
router.get('/user-details', handleUserDetials);

// to delete user
router.delete('/delete-user', handleDeleteUser);

// to update user
router.patch('/update-user', handleUpdateUser);

// to get all users
router.get('/all-users', handleGetAllUsers);

module.exports = {
    handleAddUser,
    handleUserDetials,
    handleUpdateUser,
    handleDeleteUser,
    handleGetAllUsers
}