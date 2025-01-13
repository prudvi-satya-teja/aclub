const mongoose = require('mongoose');

const eventSchema = new mongoose.Schema(
    {
        clubId: {  type: mongoose.Schema.Types.ObjectId, ref: "Club", required: true },
        eventName: { type: String, unique: true, required: true },
        date: { type: Date,  required: true },
        guest: [{ type: String }],
        location: { type: String,  required: true },
        mainTheme: { type: String, required: true },
        details: { type: String },
        image: { type: String }
    },
    {
        timestamps: true,
    }
)

const Event = mongoose.Model('events', eventSchema);

module.exports = Event;

