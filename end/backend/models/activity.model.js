const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Define the activity schema
const activitySchema = new Schema({
    name: { type: String, required: true },
    image: { type: String, required: true },
    city: { type: String, required: true },
    price: { type: Number, required: true },
    status: { type: String, default: 0 },
    status: { type: String},
    longitude: { type: Number},
    latitude: { type: Number},
});

// Export the schema (not the model)
module.exports = activitySchema;
