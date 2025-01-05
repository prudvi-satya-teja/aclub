const mongoose = require('mongoose');
const { applyTimestamps } = require('./club_model');

const dataSchema =  new mongooose.Schema(
    {
        eventName: { type: String,  required: true },
        images: [ { type: String, unique: true } ],
        videos: [ { type: String, unique: true } ]
    },
    {
        timestamps: true,
    }
)

const Data = new mongoose.model('eventData', dataSchema);
module.exports = Data





























