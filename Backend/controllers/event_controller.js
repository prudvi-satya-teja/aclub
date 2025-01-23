const mongoose = require('mongoose');
const Event = require('../models/events_model');
const Club = require('../models/club_model');

// to create event
const createEvent = async(req, res) => {
    if(!req.body.clubId || !req.body.eventName) {
        return res.status(400).json({"status": false, "msg": "please enter details "});
    }

    const club = await Club.findOne({clubId: req.body.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    }

    const event = await Event.findOne({eventName: req.body.eventName});

    if(event) {
        return res.status(400).json({"status": false, "msg": "Event already exists. please choose other name"});
    }


    const eventDetails = {
        clubId: club._id,
        eventName: req.body.eventName,
        date: req.body.date ?  req.body.date : 1-1-20,
        guest: req.body.guest ? req.body.guest : "Special guest",
        location: req.body.location ? req.body.location : "Aditya university",
        mainTheme: req.body.mainTheme ? req.body.theme : "update soon",
        details: req.body.details ? req.body.details : "update soon",
        image: req.file ? req.file.filename : null,
    }    

    try {
        const newEvent = new Event(eventDetails);
       const data = await newEvent.save();
       console.log('new event Added', data);
       return res.status(200).json({"status": true , "msg" : "Event created Successful", "event": data});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "Server Error!"});
    }
}

// to update event
const updateEvent = async(req, res) => {
    try {
        if(!req.body.clubId || !req.body.eventName) {
            return res.status(400).json({"status": false, "msg": "please enter details "});
        }

        var club = await Club.findOne({clubId: req.body.clubId});
        if(!club) {
            return res.status(400).json({"status": false, "msg": "club doesn't exists"});
        } 
        
           
        var event = await Event.findOne({eventName: req.body.eventName, clubId : club._id});
        if(!event) return res.status(404).json({"success": false, "msg": "Event doesnot exists"});
        
        
        const updatedDetails = {
            clubId: club._id,
            eventName: req.body.newEventName == null ? req.body.eventName : req.body.newEventName,
            date: req.body.newDate == null ? req.body.Date : req.body.newDate,
            guest: req.body.newGuest == null ? req.body.guest : req.body.newGuest,
            location: req.body.newLocation == null ? req.body.location : req.body.newLocation,
            mainTheme: req.body.newMainTheme == null ? req.body.mainTheme : req.body.newMainTheme,
            details: req.body.newDetails == null ? req.body.details : req.body.newDetails,
            image: req.file ? req.file.filename : null,   
        }

        console.log(updatedDetails);

        const updatedEvent = await Event.findOneAndUpdate(event, updatedDetails);
        console.log(updateEvent);
        return res.status(500).json({"status": true, "msg": "Event Updated Successfully", "updatedEvent" : updatedEvent});

    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "Server Error!"});
    }
}   
 
// to delete event
const deleteEvent = async(req, res) => {
    try {
        console.log(req.body.eventName);
        const event = await Event.findOne({eventName: req.body.eventName });
        if(!event) return res.status(404).json({"success": false, "msg": "Event not found"});
        const deletedEvent = await Event.findOneAndDelete({eventName: req.body.eventName});
        console.log(deletedEvent);
        return res.status(200).json({"status" : true, "msg" : "Event Deleted Successfully", "deleted Event": deletedEvent});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "Server Error!"});
    }
}

module.exports = {
    createEvent,
    updateEvent,
    deleteEvent
}

