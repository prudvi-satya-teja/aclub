const User = require('../models/user_model');
const bcrypt = require('bcrypt');
const {setToken} = require('../services/authentication');
const mailSender = require('./mail_sender_controller');
const otpGenerator = require('otp-generator');
const otpManager = require('../services/otp');


// to signup 
const signup = async(req, res) => {
    try {
        console.log(req.body);
        if(!req.body.firstName || !req.body.rollNo || !req.body.password) {
            return res.status(400).json({"status": false, "msg": "please enter all details"});
        }
       
        if(await User.findOne({rollNo: req.body.rollNo})) {
            return res.status(400).json({"status": false, "msg": "user with same id already exist"});
        }
        if(await User.findOne({phoneNo: req.body.phoneNo})) {
            return res.status(400).json({"status": false, "msg": "user with same phoneNo already exist"});
        }
        req.body.password  = req.body.password ? req.body.password : "aditya123";
        var userDetails = {
            firstName: req.body.firstName,
            lastName: req.body.lastName ? req.body.lastName : null,
            rollNo : req.body.rollNo,
            phoneNo: req.body.phoneNo,
            password: await bcrypt.hash(req.body.password, 12)
        }
    
        var user = new User(userDetails);
        await user.save();


        return res.status(200).json({"status": true, "msg": "user creation successful", "user": user});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

// to login
const login = async(req, res) => {
    console.log(req.body);
    if(!req.body.rollNo || !req.body.password) {
        return res.status(400).json({"status": false, "msg": "please enter all details"});
    }   
    const user = await User.findOne({rollNo: (req.body.rollNo).toLowerCase()});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {
            if(!await bcrypt.compare(req.body.password, user.password)) {
                return res.status(400).json({"status": false, "msg": "please enter correct password"});
            }
            
            const token = await setToken(user);
            console.log(token);
            return res.status(200).json({"status": true, "msg": "user login successful", "token": token});
    }
    catch(err) {
             return res.status(400).json({"status": false,"msg": "Please enter correct password"});
    }
} 

// to logout
const logout = async(req, res) => {
    // res.clearCookie("uid");
    return res.status(200).json({"status": true, "msg": "logout successful"});
}

// for forgot password
const forgotPassword = async(req, res) => {
    console.log(req.body);
    if(!req.body.rollNo || req.body.rollNo.length != 10) {
        return res.status(404).json({"status": false, "msg": "please enter valid erollNO"});
    }

    try {
        var mail = (req.body.rollNo).toLowerCase();
        if(mail[2] == 'm') mail += "@acoe.edu.in";
        else if(mail[2] ==  'p') mail += "@acet.edu.in";
        else {
            if(mail[1] <= '3')  mail += "@aec.edu.in";
            else mail += "@au.edu.in";
        }
        console.log(mail);
        var otp = otpGenerator.generate(6, {lowerCaseAlphabets: false, specialChars: false, upperCaseAlphabets: false});
        await otpManager.otpMap.set(req.body.rollNo, otp);
        // console.log("otp is  : ", otpManager.otpMap.get(rollNo));

        const sendEmail = mailSender.sendMail(mail, "otp for password resetting", `This is one time password valid for 10 minutes ${otp}`);
        
        return res.status(200).json({"status": true, "msg": "opt sent successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

// verify otp
const verifyOtp = async(req, res) => {
    console.log(req.body);
    if(!req.body.rollNo || !req.body.otp) {
        return res.status(404).json({"status" : false, "message": "please enter valid detials"});
    }

    var user = await User.findOne({rollNo: req.body.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {
        var otp =  otpManager.otpMap.get(req.body.rollNo);
        console.log(otp);
        if(otp != req.body.otp.toLowerCase()) {
            return res.status(400).json({"status": false, "msg": "please enter correct otp"});
        }   
        return res.status(200).json({"status" : true, "message": "change you password"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "serveer error"});
    }
}


// to password reset 
const setForgotPassword = async(req, res) => {
    if(!req.body.rollNo || !req.body.password) {
        return res.status(404).json({"status" : false, "message": "please enter valid detials"});
    }

    var user = await User.findOne({rollNo: req.body.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {
        user.password = await bcrypt.hash(req.body.password, 12);
        await user.save();
        return res.status(200).json({"status" : true, "message": "password changed Successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "serveer error"});
    }
}

// to password reset 
const passwordReset = async(req, res) => {
    if(!req.body.rollNo ||  !req.body.oldPassword || !req.body.newPassword) {
        return res.status(404).json({"message": "please enter valid detials"});
    }

    var user = await User.findOne({rollNo: req.body.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {

        if(!await bcrypt.compare(req.body.oldPassword, user.password)) {
            return res.status(400).json({"status": false, "msg": "please enter correct password"});
        }   
        user.password = await bcrypt.hash(req.body.newPassword, 12);
        await user.save();
        return res.status(200).json({"status" : true, "message": "password changed Successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "serveer error"});
    }
}

module.exports = {
    login,
    signup,
    logout,
    forgotPassword,
    setForgotPassword,
    passwordReset,
    verifyOtp
}