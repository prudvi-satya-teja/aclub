const Registration = require("../models/registrations_model");

// to register for an event
const registerEvent = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        if(!rollno) {
            return res.status(400).json({"status": false, "msg": "please enter valid rollno"});
        }

        const Data = {
            eventId: req.body.eventId,
            rollno: req.body.rollno,
        }

        const registration = new Registration(Data);
        const result = await create(registration);
        console.log(result);
        return res.status(200).json({"status": true, "msg": "Event registration Successful"});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to give feedback
const giveFeedback = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        if(!req.body.feedback || !req.body.rating) {
            return res.status(400).json({"status": false, "msg": "please giving feedback and rating"});
        }
        const registration = await Registration.findOne({rollNo: req.body.rollNo, eventId : req.body.eventId});
        if(!registration) {
            return res.status(400).json({"status": false, "msg": "you are not registered for the event"});
        }

        registration.feedback = req.body.feedback;
        registration.rating = req.body.rating;
        await registration.save();
        return res.status(200).json({"status": false, "msg": "feedback submitted successfully"});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get all registered Users for an event
const getAllRegisteredUsers = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        var registeredUsers =  Registration.aggregate([]);
        console.log(registeredUsers);
        return res.status(200).json({"status": true, "registered users: " : registeredUsers});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get event feedback
const getEventFeedback = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        // get feedbac
        var feedback = Registration.aggregate([]);
        console.log(feedback);
        return res.status(200).json({"status": false, "msg": "Successfully get Event feedback"});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get average rating
const getAverageRating = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        var averageRating = Registration.aggregate([]);
        console.log(averageRating);
        return res.status(200).json({"Status": true, "average Rating": averageRating});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

module.exports = {
    registerEvent,
    giveFeedback,
    getAllRegisteredUsers,
    getEventFeedback,
    getAverageRating
}
