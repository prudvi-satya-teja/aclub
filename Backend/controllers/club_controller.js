const mongoose = require("mongoose");
const Club = require("../models/club_model");

// to create a club
const createClub = async (req, res) => {
    try {
        if (!req.body.name || !req.body.clubId || !req.body.descritpion) {
            return res.status(400).json({ status: false, msg: "please provide all details" });
        }
        if (
            (await Club.findOne({ name: req.body.name })) ||
            (await Club.findOne({ clubId: req.body.clubId }))
        ) {
            return res
                .status(201)
                .json({ status: false, msg: "club with name or id already exists" });
        }

        // console.log(req.file);
        const imagePath = req.file ? req.file.filename : null;

        if (!imagePath) {
            return res.status(400).json({ status: false, msg: "image not uploaded" });
        }

        const club = new Club({
            name: req.body.name,
            clubId: req.body.clubId,
            clubImage: imagePath,
            about: req.body.description,
        });
        const newClub = await club.save();
        // console.log(newClub);
        return res
            .status(201)
            .json({ status: true, msg: "club creation successful", "club details": newClub });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ status: false, msg: "server error" });
    }
};

// to delete a club
const deleteClub = async (req, res) => {
    try {
        const club = await Club.findOne({ name: req.body.name, clubId: req.body.clubId });

        // console.log(club, req.body);
        if (!club) {
            return res.status(400).json({ status: false, msg: "club doesnot exists" });
        }
        await Club.deleteOne(club);
        // console.log(club)
        return res
            .status(201)
            .json({ status: true, msg: "club successfully deleted", "deleted club": club });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ status: false, msg: "server error" });
    }
};

//  to update club
const updateClub = async (req, res) => {
    const club = { name: req.body.name, clubId: req.body.ClubId };
    try {
        const imagePath = req.file ? req.file.filename : null;

        if (!imagePath) {
            return res.status(400).json({ status: false, msg: "image not uploaded" });
        }

        const updateClub = {
            name: req.body.newName ? req.body.newName : club.name,
            clubId: req.body.newClubId ? req.body.newClub : club.clubId,
            clubImage: req.body.imagePath,
            about: req.body.description ? req.body.newdescription : club.description,
        };

        if (await Club.findOne(club)) {
            await Club.findOneAndUpdate(club, updateClub);
            // console.log(updateClub);
            return res
                .status(200)
                .json({
                    status: true,
                    msg: "club updated successfully",
                    "updated Club": updateClub,
                });
        }
        return res
            .status(400)
            .json({ status: false, msg: "No club found with the provided details" });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ status: false, msg: "server error" });
    }
};

// to get all clubs
const getAllClubs = async (req, res) => {
    try {
        const clubs = await Club.find();
        if (clubs) return res.status(200).json({ status: true, clubs: clubs });
        return res.status(400).json({ status: false, msg: "No Clubs Found" });
    } catch (err) {
        console.log(err);
        return res.status(500).json("server error", err);
    }
};

module.exports = {
    createClub,
    deleteClub,
    updateClub,
    getAllClubs,
};
