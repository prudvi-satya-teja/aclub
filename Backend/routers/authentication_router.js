const express = require('express');
const router = express.Router();
const authenticationController = require('../controllers/authentication_controller');
const authMiddleware = require('../middlewares/authentication_authorizarization_middleware');

router.post('/login', authenticationController.login);

router.post('/signup', authenticationController.signup);

router.get('/logout', authMiddleware.restrictToLoggedUserOnly, authenticationController.logout);

router.post('/forgot-password', authenticationController.forgotPassword);

router.post('/verify-otp', authenticationController.verifyOtp);

router.post('/set-forgot-password', authenticationController.setForgotPassword);

router.post('/password-reset',authMiddleware.restrictToLoggedUserOnly, authenticationController.passwordReset);

module.exports = {
    router
}

