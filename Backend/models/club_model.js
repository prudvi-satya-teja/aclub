const mongoose = require("mongoose");

const clubSchema = new mongoose.Schema(
    {
        name: { type: String, required: true, unique: true },
        clubId: { type: String, required: true, unique: true },
        clubImage: { type: String },
        superAdmin: { type: mongoose.Schema.Types.ObjectId, ref: "users" },
        about: { type: String, required: true },
    },
    {
        timestamps: true,
    }
);

const Club = mongoose.model("clubs", clubSchema);

module.exports = Club;
