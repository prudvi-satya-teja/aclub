const mongoose = require('mongoose');

const connectToDB = (url) => {
    return mongoose.connect(url);
}

module.exports = {
    connectToDB
}