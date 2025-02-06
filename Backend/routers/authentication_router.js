const express = require('express');

const router = express.Router();
const authenticationController = require('../controllers/authentication_controller');

router.get('/login', authenticationController.login);

router.post('/signup', authenticationController.signup);

router.get('/logout', authenticationController.logout);

router.get('/password-reset', authenticationController.passwordReset);

module.exports = {
    router
}
