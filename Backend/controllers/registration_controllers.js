const Registration = require("../models/registrations_model");
const Event = require('../models/events_model');
const User = require("../models/user_model");

// to register for an event
const registerEvent = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.body.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        const user = await User.findOne({rollNo: req.body.rollNo});
        console.log(user, req.body.rollNo);
        if(!user) {
            return res.status(400).json({"status": false, "msg": "please enter valid rollno"});
        }

        const Data = {
            eventId: event._id,
            userId: user._id,
        }

        const registered = Registration.findOne(Data);
        if(registered) {
          return res.status(400).json({"status": false, "msg": "user already registered"});
        }
  
       registration = new Registration(Data);
        const result = await Registration.create(registration);
        console.log(result);
        return res.status(200).json({"status": true, "msg": "Event registration Successful", "registration": registration});
    }
    catch(err) {
        console.error(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}
 
// to give feedback
const giveFeedback = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.body.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        if(!req.body.feedback || !req.body.rating) {
            return res.status(400).json({"status": false, "msg": "please giving feedback and rating"});
        }
        const user = await User.findOne({rollNo: req.body.rollNo});
        if(!user) {
            return res.status(400).json({"status": false, "msg": "user not exists"});
        }
        const registration = await Registration.findOne({userId: user._id, eventId : event._id});
        if(!registration) {
            return res.status(400).json({"status": false, "msg": "you are not registered for the event"});
        }   

        registration.feedback = req.body.feedback;
        registration.rating = req.body.rating;
        await registration.save();
        return res.status(200).json({"status": false, "msg": "feedback submitted successfully", feedback: registration});
    }
    catch(err) {
        console.error(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get all registered Users for an event
const getAllRegisteredUsers = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.query.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        var registeredUsers = await  Registration.aggregate([
            {
              '$match': {
                'eventId': event._id
              }
            }, {
              '$lookup': {
                'from': 'users', 
                'localField': 'userId', 
                'foreignField': '_id', 
                'as': 'result'
              }
            }, {
              '$unwind': {
                'path': '$result'
              }
            }, {
              '$project': {
                'rollNo': '$result.rollNo', 
                'name': '$result.firstName', 
                '_id': 0
              }
            }
          ]);
        console.log(registeredUsers);
        return res.status(200).json({"status": true, "registered users" : registeredUsers});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get event feedback
const getEventFeedback = async(req, res) => {
    try {
        const event =await  Event.findOne({eventName: req.query.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        console.log(event._id);
        // get feedbac
        var feedback = await Registration.aggregate([
          {
            '$match': {
              'eventId': event._id
            }
          }, {
            '$lookup': {
              'from': 'users', 
              'localField': 'userId', 
              'foreignField': '_id', 
              'as': 'result'
            }
          }, {
            '$unwind': {
              'path': '$result'
            }
          }, {
            '$match': {
              'feedback': {
                '$ne': null
              }, 
              'rating': {
                '$ne': null
              }
            }
          }, {
            '$project': {
              'rollNo': '$result.rollNo', 
              'name': '$result.firstName', 
              'feedback': '$feedback', 
              'rating': '$rating',
              '_id': 0
            }
          }
        ]);
        console.log(feedback);
        return res.status(200).json({"status": true, "msg": "Successfully get Event feedback", "feedback": feedback});
    }
    catch(err) {
        console.log(err);
        return res.json(500).json({"status": false, "msg": "server error"});
    }
}

// to get average rating
const getAverageRating = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.query.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }

        var averageRating = await Registration.aggregate([
          {
            '$match': {
              'eventId': event._id
            }
          }, {
            '$group': {
              '_id': '$eventId', 
              'avgrating': {
                '$avg': '$rating'
              }
            }
          }, {
            '$unwind': {
              'path': '$avgrating'
            }
          }, {
            '$project': {
              'avgrating': 1, 
              '_id': 0
            }
          }
        ]);
          
        console.log(averageRating);
        return res.status(200).json({"average Rating": averageRating });
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

module.exports = {
    registerEvent,
    giveFeedback,
    getAllRegisteredUsers,
    getEventFeedback,
    getAverageRating
}
