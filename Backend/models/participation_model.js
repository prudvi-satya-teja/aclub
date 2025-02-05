const mongoose = require("mongoose")

const participationSchema = new mongoose.Schema(
    {
        userId: {  type: mongoose.Schema.Types.ObjectId,   ref: "users"  },
        clubId: {  type: mongoose.Schema.Types.ObjectId,    ref: "clubs" },
        role:{ type: String, enum: ["user", "coordinator","admin", ""], default: "user" }
    }, 
    {
        timestamps: true
    }
)
 
const Participation = mongoose.model('participations', participationSchema);

module.exports = Participation;