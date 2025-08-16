const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
    {
        firstName: { type: String, required: true },
        lastName: { type: String },
        rollNo: { type: String, unique: true, required: true },
        phoneNo: { type: Number },
        password: { type: String, required: true, default: "aditya123" },
    },
    {
        timestamps: true,
    }
);

const User = mongoose.model("users", userSchema);

module.exports = User;
