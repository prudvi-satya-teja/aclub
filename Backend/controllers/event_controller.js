const mongoose = require('mongoose');
const Event = require('../models/events_model');

// to create event
const createEvent = async(req, res) => {
    const eventDetails = {
        clubName: req.body.clubName,
        eventName: req.body.eventName,
        date: req.body.date,
        guest: req.body.guest,
        location: req.body.location,
        mainTheme: req.body.mainTheme,
        details: req.body.details,
        image: req.body.image
    }    

    try {
        const newEvent = new eventModel(eventDetails);
       const data = await newEvent.save();
       console.log('new event Added');
       return res.status(200).json({"status": "success" , "msg" : "Event created Successful", "event": data});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": "fail", "msg": "Server Error!"});
    }
}

// to update event
const updateEvent = async(req, res) => {
    try {
        const event = Event.findOne({eventName: req.body.oldEventName});

        if(!event) return res.status(404).json({"success": false, "msg": "Event doesnot exists"});
        
        const eventDetails = {
            clubName: req.body.newClubName == null ? req.body.clubName : req.body.newClubName,
            eventName: req.body.newEventName == null ? req.body.eventName : req.body.newEventName,
            date: req.body.newDate == null ? req.body.Date : req.body.newDate,
            guest: req.body.newGuest == null ? req.body.guest : req.body.newGuest,
            location: req.body.newLocation == null ? req.body.location : req.body.newLocation,
            mainTheme: req.body.newMainTheme == null ? req.body.mainTheme : req.body.newMainTheme,
            details: req.body.newDetails == null ? req.body.details : req.body.newDetails,
            image: req.body.newImage == null ? req.body.image : req.body.newImage,
        }

        const updatedDetails = new(eventDetails);
        const updatedEvent = await Event.findOneAndUpdate(event, updatedDetails);
        console.log(updateEvent);
        return res.status(500).json({"status": true, "msg": "Event Updated Successfully"});

    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "Server Error!"});
    }
}   
 
// to delete event
const deleteEvent = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.body.eventName });
        if(!event) return res.status(404).json({"success": false, "msg": "Event not found"});
        const deletedEvent = await Event.findOneAndDelete({eventName: req.body.eventName});
        console.log(deleteEvent);
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"status": false, "msg": "Server Error!"});
    }
}

module.exports = {
    createEvent,
    updateEvent,
    deleteEvent
}