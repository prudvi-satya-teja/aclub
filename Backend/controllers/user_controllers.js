const mongoose = require('mongoose');
const User = require('../models/user_model');
const Participation  = require('../models/participation_model');
const bcrypt = require('bcrypt');
const Club = require('../models/club_model');

// to add user
const addUser = async(req, res) => {
    try {
        if(!req.body.firstName || !req.body.rollNo || !req.body.clubId ) {
            return res.status(200).json({"Status" : false, "msg": "Please enter all details"});
        }      

        const club = await Club.findOne({clubId: req.body.clubId});
        if(!club) {
            return res.status(400).json({"status": false, "msg": "club not found"});
        }

        var user = await User.findOne({rollNo: req.body.rollNo});

        if(!user) {
            console.log(req.body);
            // if(!req.body.phoneNo || !await User.findOne({phoneNo: req.body.phoneNo})) {
            //     return res.status(400).json({"status": false, "msg": "Phone no already exists or null"});
            // }
            var userData = {
                firstName: req.body.firstName, 
                lastName: req.body.lastName, 
                rollNo: req.body.rollNo,  
                phoneNo: req.body.phoneNo, 
                password: await bcrypt.hash(req.body.password? req.body.password : "aclub@12", 12)
            }
            
            var newUser = new User(userData);
            user = await newUser.save();
        }

        console.log("user", user);
        
        var participationData = {
            clubId : club._id,
            userId : user._id,
        }

        var role = req.body.role ? req.body.role: "user";

        console.log(participationData)
        var participation = await Participation.findOne(participationData);
        console.log(participation)
        if(participation) {
            if(participation.role == req.body.role) {
                return res.status(400).json({"Status": false, "msg": "User already exists in the club"});
            }
            else {
                var result = await Participation.findOneAndUpdate(participation,  {role: req.body.role});
                return res.status(400).json({"Status": true, "msg": "User updated with the provided role", "user": user, "participation": result});
            }

        }
        // else {
        //     participationData.role = req.body.role ? req.body.role: "user";
        //     console.log(participationData);
        //     var result = await Participation.save();
        //     return res.status(400).json({"status": true, "msg": "Participation created successful", "user": user, "participation": result});
        // }

        var newParticipation = new Participation({clubId: club._id, userId: user._id, role: role } );
        console.log("new participation" ,newParticipation);
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
        if(!req.query.rollNo) {
            return res.status(400).json({"status": false, "msg": "Please enter valid rollno"});
        }
        var user = await User.findOne({rollNo: req.query.rollNo}, {firstName: 1, lastName: 1, rollNo: 1, phoneNo: 1});
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
        if(!req.body.rollNo || !req.body.password || !req.body.clubId) {
            return res.status(400).json({"Status": "Fail", "msg": "Please enter valid Details"});
        }
        
        var user = await User.findOne({rollNo: req.body.rollNo});
        if(!user) {
            return res.status(400).json({"Status": "fail","msg": "User doesn't exist" });
        }

        if(!bcrypt.compare(req.body.password, user.password)) {
            return res.status(400).json({"Status": "Fail", "msg": "Please Enter valid Password"});
        }

        var participation = Participation.findOne({clubId: req.body.clubId, rollNo: req.body.rollNo});
        if(!participation) {
            return res.status(400).json({"Status": "Fail", "msg": `User is not a member of the ${req.body.clubId}`})
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

        const deleteParticipation = await Participation.findOneAndDelete({rollNo: req.body.rollNo, clubId: req.body.clubId});

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
        var club = await  Club.findOne({clubId: req.query.clubId});
        console.log(req.query.clubId);
        if(!club) {
            return res.status(500).json({"Status": "fail", "msg": "Please enter valid clubId"})
        }
        console.log(club);
        // need to write oreectly
        var users = await  Participation.aggregate(
            [
                {
                  '$match': {
                    'clubId': club._id,
                  }
                }, {
                  '$project': {
                    'userId': 1, 
                    '_id': 0
                  }
                }, {
                  '$lookup': {
                    'from': 'users', 
                    'localField': 'userId', 
                    'foreignField': '_id', 
                    'as': 'user'
                  }
                }, {
                  '$unwind': {
                    'path': '$user'
                  }
                }, {
                  '$project': {
                    'rollno': '$user.rollNo', 
                    'name': '$user.firstName'
                  }
                }
              ]
        );
        
        return res.status(200).json({"Status": "Success", "msg": "Successful get all users", "users": users});
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

