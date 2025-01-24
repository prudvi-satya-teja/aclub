const mongoose = require('mongoose');
const Club = require('../models/club_model');

// to create a club
const createClub = async(req, res) => {
    try {
        if(await Club.findOne({name: req.body.name}) || await Club.findOne({clubId: req.body.clubId})){
          return res.status(201).json({ "success": false, "msg" : "club with name or id already exists"});
        }

        // console.log(req.file);
        const imagePath = req.file ? req.file.filename: null;

        if(!imagePath) {
            return res.status(400).json({"success": false, "msg": "image not uploaded"});
        }  

        const club = new Club({ name: req.body.name, clubId: req.body.clubId , clubImage: imagePath});
        const newClub = await club.save();
        // console.log(newClub);
        return res.status(201).json({ "success": true, "msg" : "club creation successful", "club details": newClub})
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({ "success": false, "msg" : "server error"})
    }
}

// to delete a club
const deleteClub = async(req, res) => {
    try {
        const club = await Club.findOne({ name: req.body.name, clubId: req.body.clubId});
        
        // console.log(club, req.body);
        if(!(club))  {
            return res.status(400).json({ "success": false, "msg" : "club doesnot exists"});
        }
        await Club.deleteOne(club);
        // console.log(club)
        return res.status(201).json({ "success" : true, "msg": "club successfully deleted", "deleted club": club});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({ "success": false, "msg" : "server error"})
    }
}

//  to update club
const updateClub = async(req, res) => {
    const club = { name: req.body.name, clubId: req.body.ClubId}
    try{
        const imagePath = req.file ? req.file.filename: null;

        if(!imagePath) {
            return res.status(400).json({"success": false, "msg": "image not uploaded"});
        }  
        
        const updateClub = { 
            name: req.body.newName ? req.body.newName : club.name,
            clubId: req.body.newClubId ? req.body.newClub : club.clubId,
             clubImage: req.body.imagePath
         } 
    
        if(await Club.findOne( club)) {
            await Club.findOneAndUpdate(club, updateClub);
            // console.log(updateClub);
            return res.status(200).json({"success" : true, "msg": "club updated successfully", "updated Club": updateClub});
        }
        return res.status(400).json({"success": false, "msg": "No club found with the provided details"});
    }
    catch(err) {
        console.error(err);
        return res.status(500).json({ "success": false, "msg" : "server error"});
    }
}

// to get all clubs
const getAllClubs = async(req, res) => {
    try {
        const clubs = await Club.find();
        if(clubs) return res.status(201).json(clubs);
        return res.status(400).json({"msg": "No Clubs Found"})
    }
    catch(err) {
        console.log(err);
        return res.status(500).json('server error', err);
    }
}

module.exports = {
    createClub,
    deleteClub,
    updateClub,
    getAllClubs
}

