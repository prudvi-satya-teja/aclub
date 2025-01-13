const mongoose = require('mongoose');

const dataSchema =  new mongooose.Schema(
    {
        eventId: { type: mongoose.Schema.Types.ObjectId,  required: true },
        images: [ { type: String, unique: true } ],
        videos: [ { type: String, unique: true } ]
    },  
    {
        timestamps: true,
    }
)

const Data = mongoose.model('eventData', dataSchema);

module.exports = Data





























