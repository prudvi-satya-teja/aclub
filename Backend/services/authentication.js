const jwt = require('jsonwebtoken');
require("dotenv").config()

const secret = process.env.SECRET_KEY;

const setToken = async(user) => {
    return jwt.sign({
        _id: user._id,
        rollNo: user.rollNo,
    }, secret, {
        expiresIn : "100d",
    });
}

const verifyToken = async(token) => {
    if(!token) return null;
    try {
        return jwt.verify(token, secret);
    }
    catch(err) {
        return null;
    }
}

module.exports = {
    setToken,
    verifyToken
}

