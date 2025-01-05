const mongoose = require("mongoose")

const participationSchema = new mongoose.Schema({
    user: {
        type: mongoose.Types.ObjectId,
        ref: "users"
    },
    club: {
        type: mongoose.Types.ObjectId,
        ref: "clubs"
    }
}, {
    timestamps: true
})

const Participation = new mongoose.model("participation", participationSchema);

module.exports = { Participation }