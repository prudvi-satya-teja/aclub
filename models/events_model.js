const mongoose = require('mongoose');
const { Club } = require('./club_model');

const eventSchema = new mongoose.Schema(
    {
        clubId: {  type: Schema.Types.ObjectId, ref: "Club", required: true },
        eventName: { type: String, unique: true, required: true },
        date: { type: Date,  required: true },
        guest: { type: String },
        location: { type: String,  required: true },
        mainTheme: { type: String, required: true },
        details: { type: String },
        image: { type: String }
    },
    {
        timestamps: true,
    }
)

const eventModel = new mongoose.Model('events', eventSchema);

module.exports = eventModel;

