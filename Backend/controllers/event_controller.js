const mongoose = require('mongoose');
const eventModel = require('../models/events_model');

const handleCreateEvent = async(req, res) => {
    const eventDetails = {
        clubName: req.body.clubName,
        eventName: req.body.eventName,
        date: req.body.data,
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
    catch(err) {}
}

module.exports = {
    handleCreateEvent
}