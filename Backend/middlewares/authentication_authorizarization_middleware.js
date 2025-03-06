const User = require('../models/user_model');
const Participation = require('../models/participation_model');
const {verifyToken} = require('../services/authentication');
const jwt = require("jsonwebtoken");

const restrictToLoggedUserOnly = async(req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(400).json({ "status": false, "msg": "No token provided" });
        }

        const token = authHeader.split(" ")[1];
        console.log(token);
        console.log(jwt.decode(token));
        const decodedToken = await verifyToken(token);
        console.log("decode token", decodedToken);
        if(!decodedToken) {
            return res.status(400).json({"status": false, "msg": "Invalid token"});
        } 
                  
        const { rollNo, admin } = decodedToken;
        const user = await User.findOne({rollNo: rollNo});

        req.user = user;
        req.body.rollNo = rollNo;
        req.body.isAdmin = admin;
        next();    
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}   

const whichClubAdmin = (clubs) => {
    console.log("Checking clubs:", JSON.stringify(clubs, null, 2)); 

    const adminClub = clubs.find(club => {
        console.log("Checking club:", club);
        return club.role === "admin"; // 
    });

    return adminClub ? adminClub.clubId : null; 
};


const restrictToAdminOnly = async(req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(400).json({ "status": false, "msg": "No token provided" });
        }

        const token = authHeader.split(" ")[1];
        console.log(token);
        console.log(jwt.decode(token));
        const decodedToken = await verifyToken(token);
        console.log("decode token", decodedToken);
        if(!decodedToken) {
            return res.status(400).json({"status": false, "msg": "Invalid token"});
        } 
        var rollNo = decodedToken.rollNo;
        const user = await User.findOne({rollNo: rollNo});
        
        if(!decodedToken.admin) {
            return res.status(400).json({"status": false, "msg": "You are not a admin"});
        }

        const userDetails = await User.aggregate([
            {
              '$match': {
                '_id': user._id
              }
            }, {
              '$lookup': {
                'from': 'participations', 
                'localField': '_id', 
                'foreignField': 'userId', 
                'as': 'result'
              }
            }, {
              '$unwind': {
                'path': '$result'
              }
            }, {
              '$lookup': {
                'from': 'clubs', 
                'localField': 'result.clubId', 
                'foreignField': '_id', 
                'as': 'result2'
              }
            }, {
              '$unwind': {
                'path': '$result2'
              }
            }, {
              '$group': {
                '_id': '$rollNo', 
                'firstName': {
                  '$first': '$firstName'
                }, 
                'lastName': {
                  '$first': '$lastName'
                }, 
                'phoneNo': {
                  '$first': '$phoneNo'
                }, 
                // 'password': {
                //   '$first': '$password'
                // }, 
                'clubs': {
                  '$push': {
                    'clubId': '$result2.clubId', 
                    'role': '$result.role'
                  }
                }
              }
            }
          ]);

        console.log("userdteails ", userDetails);

        const clubs = userDetails.length > 0 ? userDetails[0].clubs : [];
        console.log("Before calling isAdmin, clubs:", JSON.stringify(clubs, null, 2)); 

        req.user = user;
        req.body.rollNo = rollNo;
        req.body.isAdmin = decodedToken.admin;
        req.body.clubId = whichClubAdmin(clubs);
        console.log(req.body.clubId);

        next();  

    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

module.exports = {
    restrictToLoggedUserOnly,
    restrictToAdminOnly
}