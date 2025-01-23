const mongoose = require('mongoose');
const User = require('../models/user_model');
const Participation  = require('../models/participation_model');
const bcrypt = require('bcrypt');
const Club = require('../models/club_model');

// to add user
const addUser = async(req, res) => {
    try {
        if(!req.body.firstName || !req.body.rollNo || !req.body.clubId) {
            return res.status(200).json({"Status" : false, "msg": "Please enter all details"});
        }      

        const club = await Club.findOne({clubId: req.body.clubId});
        if(!club) {
            return res.status(400).json({"status": false, "msg": "club not found"});
        }

        var user = await User.findOne({rollNo: req.body.rollNo});

        if(!user) {
            if(await User.findOne({phoneNo: req.body.phoneNo})) {
                return res.status(400).json({"status": false, "msg": "Phone no already exists"});
            }
            var userData = {
                firstName: req.body.firstName, 
                lastName: req.body.lastName, 
                rollNo: req.body.rollNo,  
                phoneNo: req.body.phoneNo, 
                password: await bcrypt.hash(req.body.password, 12)
            }
            
            var newUser = new User(userData);
            user = User.create(newUser);
            // console.log(user);
        }
        
        var participationData = {
            clubId : club._id,
            userId : user._id,
        }

        var role = req.body.role ? req.body.role: "user";

        // console.log(participationData)
        var participation = await Participation.findOne(participationData);
        if(participation) {
            if(participation.role == req.body.role) {
                return res.status(400).json({"Status": false, "msg": "User already exists in the club"});
            }
            else {
                var result = await Participation.findOneAndUpdate(participation,  {role: req.body.role});
                return res.status(400).json({"Status": true, "msg": "User updated with the provided role", "user": user, "participation": result});
            }

        }

        var newParticipation = new Participation({participationData, role: role } );
        var resultParticipation =await  newParticipation.save();
        // console.log(resultParticipation);
        return res.status(200).json({"Status": true, "msg": "User Creation Successful", "participation": resultParticipation, "user": user});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"Status": false, "msg": "Server Error" });
    }
}

// to get user details  // need to add club and their roles 
const getUserDetails = async(req, res) => {
    try {
        if(!req.body.rollNo) {
            return res.status(400).json({"status": false, "msg": "Please enter valid rollno"});
        }
        var user = await User.findOne({rollNo: req.body.rollNo}, {firstName: 1, lastName: 1, rollNo: 1, phoneNo: 1});
        console.log(user);
        if(!user) {
            return res.status(500).json({"Status": true, "msg": "user not exists"});
        }
        // need to get the club participated and their roles
        return res.status(500).json({"Status": true,  "msg": "Successfully get user details", "details": user});
    }
    catch(err) {
        return res.status(500).json({"Status": false, "msg": ""})
    }
}

// to update user details
const updateUser = async(req, res) => {
    try {
        if(!req.body.rollNo && !req.body.password) {
            return res.status(200).json({"Status" : false , "msg": "Please enter rollNo and password"});
        }

        const user = await User.findOne({rollNo: rollNo});
        
        if(!user) {
            return res.status(400).json({"Status": false, "msg": "User doesn't exist"});
        }

        if(!await bcrypt.compare(user.password, req.body.password)) {
            return res.status(400).json({"Status": false , "msg": "Please enter valid password"})
        }
        var userData = {
            firstName: req.body.firstName ? user.firstName : req.body.firstName, 
            lastName: req.body.lastName ? user.lastName : req.body.lastName, 
            rollNo: req.body.newRollNo ? user.rollNo : req.body.newRollNo,  
            phoneNo: req.body.phoneNo ? user.phoneNo : req.body.phoneNo, 
            password: req.body.newpassword? user.password :  await bcrypt.hash(req.body.newpassword, 12)
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

// to get all users  // need to write the aggregations
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
                        _id: req.body.clubName,
                    },
                    $project : {}
                }
            ]
        );
            // return res.status(200).json("Status": "Success", "msg": "Successful get all users")];
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": "fail", "msg": "Server Error"});
    }

}

module.exports = {
    addUser,
    getUserDetails,
    updateUser,
    deleteUser,
    getAllUsers
}

