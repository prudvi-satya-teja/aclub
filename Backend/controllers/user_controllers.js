const mongoose = require('mongoose');
const User = require('../models/user_model');
const Participation  = require('../models/participation_model');
const bcrypt = require('bcrypt');

// to add user
const addUser = async(req, res) => {
    try {
        if(!req.body.firstName || !req.body.rollNo || !req.body.clubName) {
            return res.status(200).json({"Status" : "fail", "msg": "Please enter all details"});
        }
        
        var userData = {
            firstName: req.body.firstName, 
            lastName: req.body.lastName, 
            rollNo: req.body.rollNo,  
            phoneNo: req.body.phoneNo, 
            password: await bcrypt.hash(req.body.password, 12)
        }

        var participationData = {
            eventName: req.body.clubName,
            rollNo: req.body.rollNo,
            role : req.body.role,
        }

        if(await Participation.findOne({clubName: req.body.eventName , rollNo: req.body.rollNo})) {
            return res.status(400).json({"Status": "fail", "msg": "User already exists in the club"});
        }

        var newUser = new User(userData);
        var resultUser = User.create(newUser);
        console.log(resultUser);

        var newParticipation = new Participation(participationData);
        var resultParticipation = Participation.create(newParticipation);
        console.log(resultParticipation);
        return res.status(200).json({"Status": "fail", "msg": "User Creation Successful"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": "fail", "msg": "Server Error" });
    }
}

// to get user details
const getUserDetails = async(req, res) => {
    try {
        if(!req.body.rollNo) {
            return res.status(400).json({"status": "Fail", "msg": "Please enter valid rollno"});
        }
        var user = await User.findOne({rollNo: req.body.rollNo});
        console.log(user);
        // need to get the club participated and their roles
        return res.status(500).json({"Status": "fail",  "msg": "Successfully get user details"});
    }
    catch(err) {
        return res.status(500).json({"Status": "Fail", "msg": ""})
    }
}

// to update user details
const updateUser = async(req, res) => {
    try {
        if(!req.body.newfirstName || !req.body.oldRollNo || !req.body.newClubName || !req.body.newPhoneNo || !req.body.oldPassword || 
            !req.body.newPassword
        ) {
            return res.status(200).json({"Status" : "fail", "msg": "Please enter all details"});
        }

        const user = await User.findOne({rollNo: oldRollNo});

        if(!user) {
            return res.status(400).json({"Status": "Fail", "msg": "User doesn't exist"});
        }
        if(!await bcrypt.compare(user.password, oldPassword)) {
            return res.status(400).json({"Status": "Fail", "msg": "Please enter valid password"})
        }
        var userData = {
            firstName: req.body.newfirstName, 
            lastName: req.body.newlastName, 
            rollNo: req.body.newrollNo,  
            phoneNo: req.body.newphoneNo, 
            password: await bcrypt.hash(req.body.newpassword, 12)
        }

        var newUser = new User(userData);
        var resultUser = User.findOneAndUpdate(user, newUser);
        console.log(resultUser);
        return res.status(200).json({"Status": true, "msg": "User Updation Successful"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error" });
    }
}

// to delete user
const deleteUser = async(req, res) => {
    try {
        if(!req.body.rollNo || !req.body.password || !req.body.clubName) {
            return res.status(400).json({"Status": "Fail", "msg": "Please enter valid Details"});
        }
        
        var user = await User.findOne({rollNo: req.body.rollNo});
        if(!user) {
            return res.status(400).json({"Status": "fail","msg": "User doesn't exist" });
        }

        if(!bcrypt.compare(req.body.password, user.password)) {
            return res.status(400).json({"Status": "Fail", "msg": "Please Enter valid Password"});
        }

        var participation = Participation.findOne({clubName: req.body.clubName, rollNo: req.body.rollNo});
        if(!participation) {
            return res.status(400).json({"Status": "Fail", "msg": `User is not a member of the ${req.body.clubName}`})
        }

        var participationCount = Participation.aggregate(
            [
                {
                    $sum : {
                        _id: "$Participation.rollNo",
                        count: {  $sum: 1 }
                    }
                }
            ]
        );

        const deleteParticipation = await Participation.findOneAndDelete({rollNo: req.body.rollNo, clubName: req.body.clubName});

        if(participationCount == 1)  {
            const deleteUser = await User.findOneAndDelete({rollNo: req.body.rollNo});
        }
        return res.status(200).json({"Status": "Fail", "msg": "User delete successful"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": "Fail", "msg": "Server Error"});
    }
}

// to get all users
const getAllUsers = async(req, res) => {
    try {
        if(!req.body.clubName) {
            return res.status(500).json({"Status": "fail", "msg": "Please enter valid clubname"})
        }
        // need to write oreectly
        var users =  Participation.aggregate(
            [
                {
                    $group : {
                        _id: "$clubName",
                    }
                }
            ]
        );
            // return res.status(200).json("Status": "Success", "msg": "Successful get all users")];
    }
    catch(err) {
        console.log(err);
        return ress.status(500).json({"status": "fail", "msg": "Server Error"});
    }

}

module.exports = {
    addUser,
    getUserDetails,
    updateUser,
    deleteUser,
    getAllUsers
}

