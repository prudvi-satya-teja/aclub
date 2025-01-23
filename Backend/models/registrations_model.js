const mongoose = require('mongoose');

const registrationSchema = new mongoose.Schema(
    {
        eventId: { type: mongoose.Schema.Types.ObjectId },
        userId: { type: mongoose.Schema.Types.ObjectId },
        feedback: { type: String },
        rating: { type: Number }  
    },
    {
        timestamps: true,
    }
)

const Registration = mongoose.model('registrations', registrationSchema);


module.exports = Registration;
