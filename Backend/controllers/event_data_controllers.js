// to upload image
const uploadImage = async(req, res) => {
    try {
        if(!req.body.eventId || !req.body.imageUrl) {
            return res.status(400).json({"status": false, "msg" : "please enter valid details"});
        }
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"Status": false, "msg": "Event doesn't exist"});
        }
        
        const result = await EventData.findOneAndUpdate(
            {eventId: req.body.eventId},
            { $addToSet : {images: req.body.imageurl}},
            { new : true, upsert:false}
        );

        return res.status(200).json({"Status" : true, "msg": "image added Successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }

}

// to upload video
// const uploadVideo = async(req, res) => {
// }

// to delete image
const deleteImage = async(req, res) => {
    try {
        if(!req.body.eventId || !req.body.imageUrl) {
            return res.status(400).json({"status": false, "msg" : "please enter valid details"});
        }
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"Status": false, "msg": "Event doesn't exist"});
        }
        
        const result = await EventData.findOneAndDelete(
            {eventId: req.body.eventId},
            { $pull : {images: req.body.imageurl}},
            { new : true, upsert:false}
        );

        return res.status(200).json({"Status" : true, "msg": "image added Successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }
}

// to delete video
// const deleteVideo = async(req, res) => {
// }

// to update image
// const updateImage = async(req, res) => {
// }

// to update video
// const updateVideo = async(req, res) => {
// }

//to get Images
const getImages = async(req, res) => {
    try {
        const event = Event.findOne({eventId: req.body.eventId});
        if(!event) {
            return res.status(400).json({"Status": false, "msg": "Event doesn't exist"});
        }
        
        const result = await EventData.findOne(
            {eventId: req.body.eventId}
        );

        console.log(result.images);
        return res.status(200).json({"Status" : true, "msg": "image added Successfully"});
    }
    catch(err) {
        console.log(err);
        return res.status(500).json({"Status": false, "msg": "Server Error"});
    }
}

// to get Videos
// const getVideos = async(req, res) => {
// }

module.exports = {
    uploadImage,
    uploadVideo,
    deleteImage,
    deleteVideo,
    updateImage,
    updateVideo,
    getImages,
    getVideos
}