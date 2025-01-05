const mongoose = require('mongoose');

const registrationSchema = new mongoose.Schema({
        eventName: { type: Schema.Types.ObjectId },
        rollno: { type: String },
        feedback: { type: String },
        rating: { type: Number }
})

