const Data = require('../models/events_data_model');
const Event = require('../models/events_model');
// to upload image
const uploadImage = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.body.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        
        var imageUrls = req.files ? req.files.map(file=>file.path) : null;

        if(!imageUrls) {
            return res.status(400).json({"status": false, "msg": "file paths are not there"});
        }
    
        let eventData = await Data.findOne({eventId: event._id});

        if(!eventData) {
            eventData = new Data({eventId: event._id});
            await eventData.save();
        }

        // console.log("eventdata : " ,eventData);

        const result = await Data.findOneAndUpdate(
            {eventId: event._id },
            { $addToSet : {images: {$each: imageUrls}}},
            { new : true, upsert:false}
        );


        // console.log("resutl" , result);

        return res.status(200).json({"Status" : true, "msg": "image added Successfully", "links": result});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }

}

// to delete image
const deleteImage = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.body.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        
        let imageUrls = req.files ? req.files.map(file => file.path) : null;

        if(!imageUrls || imageUrls.length == 0) {
            return res.status(400).json({"status": false, "msg": "file paths are not there"});
        }
        // console.log("urls" ,imageUrls);
        const result = await Data.findOneAndUpdate(
            {eventId: event._id},
            { $pull : {images:{ $in: imageUrls}}},
            { new : true}
        ); 
        // console.log(result);
        if (!result) {
            return res.status(400).json({ status: false, msg: "No matching images found" });
        }

        return res.status(200).json({"Status" : true, "msg": "image deleted Successfully", "result": result});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }
}

//to get Images
const getImages = async(req, res) => {
    try {
        const event = await Event.findOne({eventName: req.query.eventName});
        if(!event) {
            return res.status(400).json({"status": false, "msg": "event doesn't exists"});
        }
        
        const result = await Data.findOne(
            {eventId: event._id}
        );

        // console.log(result.images);
        return res.status(200).json({"Status" : true, "msg": "images get Successfully", "result": result.images});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }
}

module.exports = {
    uploadImage,
    deleteImage,
    getImages,
}