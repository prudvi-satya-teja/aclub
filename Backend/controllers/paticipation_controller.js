const Participation = require('../models/participation_model');
const Club = require('../models/club_model');

//to get admin and coordinator from a specific club
const getClubMembers = async (req, res) => {
    var club = await Club.findOne({clubId: req.query.clubId});
    if(!club) {
        return res.status(400).json({"status": false, "msg": "club doesn't exists"});
    } 

    try {
        const result = await Participation.aggregate([
          {
            '$match': {
              'clubId': club._id, 
              'role': {
                '$in': [
                  'admin', 'coordinator'
                ]
              }
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
              'firstName': '$result.firstName', 
              'lastName': '$result.lastName', 
              'rollNo': '$result.rollNo', 
              'phoneNo': '$result.phoneNo', 
              'role': 1, 
              '_id': 0
            }
          }, {
            '$sort': {
              'role': 1
            }
          }
        ]);

          console.log(result);
        return res.status(200).json({"status": true, "msg": "get members successful", "members":result})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({"status": false, "msg": "server error"});
    }

}

module.exports = {
    getClubMembers
}