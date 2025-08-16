const jwt = require("jsonwebtoken");
require("dotenv").config();

const User = require("../models/user_model");
const secret = process.env.SECRET_KEY;

const isAdmin = (clubs) => {
    console.log("Checking clubs:", JSON.stringify(clubs, null, 2));

    if (!Array.isArray(clubs)) {
        console.log("isAdmin failed: clubs is not an array");
        return false;
    }

    return clubs.some((club) => {
        console.log("Checking club:", club);
        return club.role === "admin";
    });
};

const setToken = async (user, userDetails) => {
    const secret = process.env.JWT_SECRET || "ACLUB65@70";

    const clubs = userDetails.length > 0 ? userDetails[0].clubs : [];

    console.log("Before calling isAdmin, clubs:", JSON.stringify(clubs, null, 2));

    const adminStatus = isAdmin(clubs);

    console.log("Final isAdmin result:", adminStatus);

    return jwt.sign(
        {
            _id: user._id,
            admin: adminStatus,
            rollNo: user.rollNo,
        },
        secret,
        {
            expiresIn: "1000d",
        }
    );
};

const verifyToken = async (token) => {
    console.log("token is", token);
    if (!token) return null;
    try {
        const decoded = jwt.verify(token, secret);
        return decoded;
    } catch (err) {
        console.error(err);
        return null;
    }
};

module.exports = {
    setToken,
    verifyToken,
};
