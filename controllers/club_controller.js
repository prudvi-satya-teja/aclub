const mongoose = require('mongoose');
const Club = require('../models/club_model');

// to create a club
const handleCreateClub = async(req, res) => {
    try {
        if(await Club.findOne({name: req.body.name}) || await Club.findOne({clubId: req.body.clubId})){
          return res.status(201).json({ "success": false, "msg" : "club with name or id already exists"});
        }

        console.log(req.file);
        const imagePath = req.file ? req.file.filename: null;
        // console.log(imagePath)

        if(!imagePath) {
            return res.status(400).json({"success": false, "msg": "image not uploaded"});
        }

        const club = new Club({ name: req.body.name, clubId: req.body.clubId , clubImage: imagePath});
        const newclub = await club.save();
        console.log(newclub);
        return res.status(201).json({ "success": true, "msg" : "club creation successful"})
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({ "success": false, "msg" : "server error"})
    }
}


// to delete a club
const handleDeleteClub = async(req, res) => {
    try {
        const club = { name: req.body.name, clubId: req.body.clubId}
        if(!(await Club.findOne(club)))  {
            return res.status(400).json({ "success": false, "msg" : "club doesnot exists"});
        }

        await Club.deleteOne(club);
        console.log(club)
        return res.status(201).json({ "success" : true, "msg": "club successfully deleted"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({ "success": false, "msg" : "server error"})
    }
}

//  to update club
const handleUpdateClub = async(req, res) => {
    const prevclub = { name: req.body.prevname, clubId: req.body.prevId}
    const updateClub = { name: req.body.newname, clubId: req.body.newId}
    try{

        if(await Club.findOne(prevclub)) {
            await Club.findOneAndUpdate(prevclub, updateClub);
            console.log(updateClub);
            return res.status(200).json({"success" : true, "msg": "club updated successfully"});
        }
        return res.status(400).json({"success": false, "msg": "No club found with the provided details"});
    }
    catch(err) {
        console.log({ "success": false, "msg" : "server error"});
    }
}

// to get all clubs
const handleGetAllClubs = async(req, res) => {
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
    handleCreateClub,
    handleDeleteClub,
    handleUpdateClub,
    handleGetAllClubs
}

