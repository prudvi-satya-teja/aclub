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
        return res.status(200).json({"statsu": true, "msg": "user creation successful", "user": user});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

const login = async(req, res) => {
    if(!req.query.rollNo || !req.query.password) {
        return res.status(400).json({"status": false, "msg": "please enter all details"});
    }   
    const user = await User.findOne({rollNo: req.query.rollNo});
    if(!user) {
        return res.status(400).json({"status": false, "msg": "user doesn't exists"});
    }

    try {
            if(!await bcrypt.compare(req.query.password, user.password)) {
                return res.status(400).json({"status": false, "msg": "please enter correct password"});
            }
            
            const token = await setToken(user);
            // res.cookie("uid", token, {
            //     httpOnly : true,
            //     maxAge: "100d"    
            // });
            console.log(token);
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
    if(!req.body.rollNo || !req.body.oldPassword || !req.body.newPassword) {
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
    passwordReset
}