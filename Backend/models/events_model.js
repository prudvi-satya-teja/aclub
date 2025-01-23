const mongoose = require('mongoose');

const eventSchema = new mongoose.Schema(
    {
        clubId: {  type: mongoose.Schema.Types.ObjectId, ref: "Club", required: true },
        eventName: { type: String, unique: true, required: true },
        date: { type: Date },
        guest: [{ type: String }],
        location: { type: String },
        mainTheme: { type: String },
        details: { type: String },
        image: { type: String }
    },
    {
        timestamps: true,
    }
)

const Event = mongoose.model('events', eventSchema);

module.exports = Event;

