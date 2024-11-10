const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const activitySchema = require("./activity.model");

const tripSchema = Schema({
    city: String,
    activities: [activitySchema], // Using the imported activity schema
    date: Date
});

const Trip = mongoose.model("Trip", tripSchema); // Model name capitalized

module.exports = Trip;
