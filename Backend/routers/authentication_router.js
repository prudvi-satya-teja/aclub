const express = require('express');

const router = express.Router();
const authenticationController = require('../controllers/authentication_controller');
const authMiddleware = require('../middlewares/authentication_middleware');

router.get('/login', authenticationController.login);

router.post('/signup', authenticationController.signup);

router.get('/logout', authMiddleware.restrictToAdminOnly, authenticationController.logout);

router.post('/password-reset',authMiddleware.restrictToAdminOnly, authenticationController.passwordReset);

module.exports = {
    router
}

