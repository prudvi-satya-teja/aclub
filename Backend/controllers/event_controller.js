const mongoose = require('mongoose');
const Event = require('../models/events_model');
const Club = require('../models/club_model');
const { events } = require('../models/participation_model');

// to create event
const createEvent = async(req, res) => {
    console.log("controller body", req.body);
    if(!req.user.clubId || !req.body.eventName) {
        return res.status(400).json({"status": false, "msg": "please enter details "});
    }
    console.log(req.body);
    console.log(req.file);
    const club = await Club.findOne({clubId: req.user.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    }

    const event = await Event.findOne({eventName: req.body.eventName});

    if(event) {
        return res.status(400).json({"status": false, "msg": "Event already exists. please choose other name"});
    }

    const imageUrl = `https://res.cloudinary.com/${process.env.CLOUDINARY_CLOUD_NAME}/image/upload/${req.file?.path}`;

    console.log(req.user.clubId);

    console.log(club);
    
    const eventDetails = {
        clubId: club._id,
        eventName: req.body.eventName,
        date: req.body.date ?  req.body.date : 1-1-20,
        guest: req.body.guest ? req.body.guest : "Special guest",
        location: req.body.location ? req.body.location : "Aditya university",
        mainTheme: req.body.mainTheme ? req.body.theme : "update soon",
        details:req.body.details ? req.body.details: "update soon",
        image:  req.file?.path? req.file.path : null,
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
// const updateEvent = async(req, res) => {
//     try {
//         if(!req.body.clubId || !req.body.eventName) {
//             return res.status(400).json({"status": false, "msg": "please enter details "});
//         }

//         var club = await Club.findOne({clubId: req.body.clubId});
//         if(!club) {
//             return res.status(400).json({"status": false, "msg": "club doesn't exists"});
//         } 
        
           
//         var event = await Event.findOne({eventName: req.body.eventName, clubId : club._id});
//         if(!event) return res.status(404).json({"success": false, "msg": "Event doesnot exists"});
        
        
//         const updatedDetails = {
//             clubId: club._id,
//             eventName: req.body.newEventName == null ? req.body.eventName : req.body.newEventName,
//             date: req.body.newDate == null ? req.body.Date : req.body.newDate,
//             guest: req.body.newGuest == null ? req.body.guest : req.body.newGuest,
//             location: req.body.newLocation == null ? req.body.location : req.body.newLocation,
//             mainTheme: req.body.newMainTheme == null ? req.body.mainTheme : req.body.newMainTheme,
//             details: req.body.newDetails == null ? req.body.details : req.body.newDetails,
//             image: req.file ? req.file.filename : null,   
//         } 

//         console.log(updatedDetails);

//         const updatedEvent = await Event.findOneAndUpdate(event, updatedDetails);
//         console.log(updateEvent);
//         return res.status(500).json({"status": true, "msg": "Event Updated Successfully", "updatedEvent" : updatedEvent});

//     }
//     catch(err) {
//         console.error(err);
//         return res.status(500).json({"status": false, "msg": "Server Error!"});
//     }
// }  
const updateEvent = async (req, res) => {
    try {
      console.log(req.body);
        const { clubId, eventName, newEventName, newDate, newGuest, newLocation, newMainTheme, newDetails } = req.body;

        // Validate input
        if (!clubId || !eventName) {
            return res.status(400).json({ status: false, msg: "Please enter details" });
        }

        // Find the club
        const club = await Club.findOne({ clubId });
        if (!club) {
            return res.status(400).json({ status: false, msg: "Club doesn't exist" });
        }

        // Find the event in the club
        const event = await Event.findOne({ eventName, clubId: club._id });
        if (!event) {
            return res.status(404).json({ success: false, msg: "Event does not exist" });
        }  

        const imageUrl = `${req.file?.path}`;

        // Prepare updated details
        const updatedDetails = {
            eventName: newEventName ? newEventName :  event.eventName,
            date: newDate ? newDate:  event.date,
            guest: newGuest ? newGuest:  event.guest,
            location: newLocation ?newLocation:   event.location,
            mainTheme: newMainTheme ?newMainTheme:  event.mainTheme,
            details: newDetails ?newEventName:  event.details,
            image: imageUrl ? imageUrl : event.image,
        };

        console.log(updatedDetails);

        // Update event and return updated document
        const updatedEvent = await Event.findOneAndUpdate(
            { _id: event._id },
            updatedDetails,
            { new: true } // Return the updated document
        );

        return res.status(200).json({ status: true, msg: "Event Updated Successfully", updatedEvent });

    } catch (err) {
        console.error(err);
        return res.status(500).json({ status: false, msg: "Server Error!" });
    }
};

 
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
                    'date': '$$NOW'
                  }
                }
              ]
            }
          }
        }, {
          '$lookup': {
            'from': 'clubs', 
            'localField': 'clubId', 
            'foreignField': '_id', 
            'as': 'result'
          }
        }, {
          '$sort': {
            'date': 1
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
            'guest': 1, 
            '_id': 0
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
                    'date': '$$NOW'
                  }
                }
              ]
            }
          }
        }, {
          '$sort': {
            'date': 1
          }
        }, {
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
            'guest': 1, 
            '_id': 0
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
          '$match': {
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
                    'date': '$$NOW'
                  }
                }
              ]
            }
          }
        }, {
          '$lookup': {
            'from': 'clubs', 
            'localField': 'clubId', 
            'foreignField': '_id', 
            'as': 'result'
          }
        }, {
          '$sort': {
            'date': -1
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
            'guest': 1, 
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

// to get one event data by name
const getEventDetails = async(req,res) => {
    const event = await Event.findOne({"eventName": req.query.eventName});
    if(!event) {
      return res.status(400).json({"status": false, "msg": "event not found"});
    }

    try {
        var eventDetails = await Event.aggregate([
          {
            '$match': {
              'eventName': req.query.eventName
            }
          }, {
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
              '_id': 0, 
              'date': 1, 
              'eventName': 1, 
              'guest': 1, 
              'location': 1, 
              'details': 1, 
              'image': 1, 
              'clubName': '$result.name',
              'clubId': '$result.clubId', 
              'mainTheme': 1
            }
          }
        ]);
        return res.status(200).json({"status": true, "msg": "details get successful", "eventDetails": eventDetails});
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
    getAllPastEvents,
    getEventDetails
}

