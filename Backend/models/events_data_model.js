const mongoose = require('mongoose');

const dataSchema =  new mongoose.Schema(
    {
        eventId: { type: mongoose.Schema.Types.ObjectId,  required: true },
        images: [ { type: String } ],
        videos: [ { type: String } ]
    },  
    {
        timestamps: true,
    }
);

const Data = mongoose.model('eventdatas', dataSchema);

module.exports = Data





























