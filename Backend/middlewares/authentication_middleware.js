const User = require('../models/user_model');
const Participation = require('../models/participation_model');
const {verifyToken} = require('../services/authentication');


const restrictToLoggedUserOnly = async(req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];

    try {
        if(!token) {
            return res.status(400).json({"status": false, "msg": "no token provided"});
        }

        const decodedToken = await verifyToken(token);

        if(!decodedToken) {
            return res.status(400).json({"status": false, "msg": "Invalid token"});
        } 

        var rollNo = decodedToken.rollNo;
        const user = await User.findOne({rollNo: rollNo});

        req.user = user;
        next();

    }
    catch(err) {
        console.err(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}   

const restrictToAdminOnly = async(req, res, next) => {
    const token = req.headers.authorizaion.split(' ')[1];

    try {
        if(!token) {
            return res.status(400).json({"status": false, "msg": "no token provided"});
        }

        const decodedToken = await verifyToken(token);

        if(!decodedToken) {
            return res.status(400).json({"status": false, "msg": "Invalid token"});
        } 

        var rollNo = decodedToken.rollNo;
        const user = await User.findOne({rollNo: rollNo});

        if()

        req.user = user;
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