const mongoose = require('mongoose');
const Event = require('../models/events_model');
const Club = require('../models/club_model');
const { events } = require('../models/participation_model');

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
    //    console.log('new event Added', data);
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

// to get all events related to specific club
const getAllEvents = async(req, res) => {
  console.log("hello", req.body);
    var club = await Club.findOne({clubId: req.body.clubId});
    console.log("hello", req.body);
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    } 

    try {
        const result = await Event.aggregate([
            {
            '$match': {
                'clubId': club._id,
            }
            }
        ]);

        result.clubId = req.body.clubId;
        //   console.log(result);
        return res.status(200).json({"status": true, "msg": "events get successful", "events":result})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }


}

// to get ongoing events for a specific club
const getOngoingEvents = async(req, res) => {
  console.log(req.query);
    var club = await Club.findOne({clubId: req.query.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    } 

    try {
        const result = await Event.aggregate([
            {
              '$match': {
                'clubId': club._id, 
                '$expr': {
                  '$eq': [
                    {
                      '$dateToString': {
                        'format': '%Y-%m-%d',
                        'date': '$date'
                      }          
                    }, {
                      '$dateToString': {
                        'format': '%Y-%m-%d', 
                        'date': new Date()
                      }
                    }
                  ]
                }
              }
            }
          ]);

        //   console.log(result);
        return res.status(200).json({"status": true, "msg": "events get successful", "ongoing events":result})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

// to get upcoming events for a specific club
const getUpcomingEvents = async(req,res) => {
    var club = await Club.findOne({clubId: req.query.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    } 

    try {
        const result = await Event.aggregate([
            {
              '$match': {
                'clubId': club._id, 
                '$expr': {
                  '$gt': [
                    {
                      '$dateToString': {
                        'format': '%Y-%m-%d', 
                        'date': '$date'
                      }
                    }, {
                      '$dateToString': {
                        'format': '%Y-%m-%d', 
                        'date': new Date()
                      }
                    }
                  ]
                }
              }
            }, {
              '$sort': {
                'date': 1
              }
            }
          ]);

          console.log(result);
        return res.status(200).json({"status": true, "msg": "events get successful", "upcoming events":result})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

// to get past event for a specific club
const getPastEvents = async(req, res) => {
    var club = await Club.findOne({clubId: req.query.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    } 

    try {
        const result = await Event.aggregate([
            {
              '$match': {
                'clubId': club._id, 
                '$expr': {
                  '$lt': [
                    {
                      '$dateToString': {
                        'format': '%Y-%m-%d', 
                        'date': '$date'
                      }
                    }, {
                      '$dateToString': {
                        'format': '%Y-%m-%d', 
                        'date': new Date()
                      }
                    }
                  ]
                }
              }
            }, {
              '$sort': {
                'date': -1
              }
            }
          ]);

        //   console.log(result);
        return res.status(200).json({"status": true, "msg": "events get successful", "past events":result})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }
}

// to get all ongoing events
const getAllOngoingEvents = async(req, res) => {
  try {
      const result = await Event.aggregate([
          {
            '$match': {
              '$expr': {
                '$eq': [
                  {
                    '$dateToString': {
                      'format': '%Y-%m-%d', 
                      'date': '$date'
                    }
                  }, {
                    '$dateToString': {
                      'format': '%Y-%m-%d', 
                      'date': new Date()
                    }
                  }
                ]
              }
            }
          }
        ]);

      //   console.log(result);
      return res.status(200).json({"status": true, "msg": "events get successful", "ongoing events":result})
  }
  catch(err) {
      console.error(err);
      return res.status(500).json({"status": false, "msg": "server error"});
  }
}

// to get upcoming events for a specific club
const getAllUpcomingEvents = async(req,res) => {

  try {
      const result = await Event.aggregate([
          {
            '$match': {
              '$expr': {
                '$gt': [
                  {
                    '$dateToString': {
                      'format': '%Y-%m-%d', 
                      'date': '$date'
                    }
                  }, {
                    '$dateToString': {
                      'format': '%Y-%m-%d', 
                      'date': new Date()
                    }
                  }
                ]
              }
            }
          }, {
            '$sort': {
              'date': 1
            }
          }
        ]);

        console.log(result);
      return res.status(200).json({"status": true, "msg": "events get successful", "upcoming events":result})
  }
  catch(err) {
      console.error(err);
      return res.status(500).json({"status": false, "msg": "server error"});
  }
}

// to get past event for a specific club
const getAllPastEvents = async(req, res) => {

  try {
      const result = await Event.aggregate([
        {
          '$lookup': {
            'from': 'clubs', 
            'localField': 'clubId', 
            'foreignField': '_id', 
            'as': 'result'
          }
        }, {
          '$unwind': {
            'path': '$result'
          }
        }, {
          '$project': {
            'location': 1, 
            'clubName': '$result.name', 
            'clubId': '$result.clubId', 
            'image': 1, 
            'details': 1, 
            'eventName': 1, 
            'date': 1, 
            'location': 1, 
            'guests': 1, 
            '_id': 0
          }
        }
      ]);

      //   console.log(result);
      return res.status(200).json({"status": true, "msg": "events get successful", "past events":result})
  }
  catch(err) {
      console.error(err);
      return res.status(500).json({"status": false, "msg": "server error"});
  }
}


module.exports = {
    createEvent,
    updateEvent,
    deleteEvent,
    getAllEvents,
    getOngoingEvents,
    getUpcomingEvents,
    getPastEvents,
    getAllOngoingEvents,
    getAllUpcomingEvents,
    getAllPastEvents
}

