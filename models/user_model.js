const mongoose = require('mongoose');

const userSchema = new mongoose.Schema(
    {
        firstname: {  type: String, required: true },
        lastname: {  type: String  },
        rollno: { type: String, unique: true, required: true },
        phoneno: { type: Number, unique: true, required: true },
       
    }
)

const User = new mongoose.model('users', userSchema);

module.exports = User

