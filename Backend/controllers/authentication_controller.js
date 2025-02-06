const User = require('../models/user_model');
const bcrypt = require('bcrypt');
const {setToken} = require('../services/authentication');

const signup = async(req, res) => {
    try {
        if(!req.body.firstName || !req.body.rollNo || !req.body.password) {
            return res.status(400).json({"status": false, "msg": "please enter all details"});
        }
       
        if(await User.findOne({rollNo: req.body.rollNo})) {
            return res.status(400).json({"status": false, "msg": "user with same id already exist"});
        }
    
        var userDetails = {
            firstName: req.body.firstName,
            lastName: req.body.lastName ? req.body.lastName : null,
            rollNo : req.body.rollNo,
            phoneNo: req.body.password ? req.body.password : "aditya123",
            password: await bcrypt.hash(req.body.password, 12)
        }
    
        var user = new User(userDetails);
        await user.save();
        return res.status(200).json({"statsu": true, "msg": "user creation successful"});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

const login = async(req, res) => {
    if(!req.body.rollNo || !req.body.password) {
        return res.status(400).json({"status": false, "msg": "please enter all details"});
    }   
    const user = await User.findOne({rollNo: req.body.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {

            if(!await bcrypt.compare(req.body.password, user.password)) {
                return res.status(400).json({"status": false, "msg": "please enter correct password"});
            }

            const token = setToken(user);
            // res.cookie("uid", token, {
            //     httpOnly : true,
            //     maxAge: "100d"    
            // });

            return res.status(200).json({"status": true, "msg": "user login successful", "token": token});
    }
    catch(err) {
             return res.status(400).json({"message": "Please enter correct password"});
    }
}

const logout = async(req, res) => {
    // res.clearCookie("uid");
    return res.status(200).json({"status": true, "msg": "logout successful"});
}

const passwordReset = async(req, res) => {
    if(!req.body.email || !req.body.oldPassword || !req.body.newPassword) {
        return res.json(404).json({"message": "please enter valid detials"});
    }

    var user = await User.findOne({rollNo: req.body.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {
        if(req.body.password != await bcrypt.compare(req.body.password, user.password)) {
            return res.status(400).json({"status": false, "msg": "please enter correct password"});
        }   
        user.password = req.body.newPassword;
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
    passwordReset
}