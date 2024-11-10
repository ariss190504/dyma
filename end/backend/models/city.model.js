const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const activitySchema = require("./activity.model"); // Import the activity schema, not the model

// Define the City schema
const citySchema = new Schema({
    image: String,
    name: String,
    activities: [activitySchema], // Use activitySchema (the schema, not the model)
});

// Create and export the City model
const City = mongoose.model("City", citySchema);

module.exports = City;
