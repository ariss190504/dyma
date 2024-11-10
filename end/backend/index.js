const express = require('express');
const mongoose = require('mongoose');
const app = express();
const path = require('path');
const City = require('./models/city.model');
const Trip = require('./models/trip.model');
const multer = require('multer');

const subpath = 'public/assets/images/activities';
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, path.join(__dirname, subpath));
    },
    filename: function(req, file, cb) {
        cb(null, file.originalname);
    }
});

const upload = multer({ storage });

mongoose.set('debug', true);
mongoose.connect('mongodb+srv://jean:123@cluster0.i28ak.mongodb.net/dymatrip?retryWrites=true&w=majority&appName=Cluster0')
    .then(() => console.log('Connection successful!'))
    .catch((err) => console.error('Connection error:', err));

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());

app.get("/api/cities", async (req, res) => {
    try {
        const cities = await City.find({}).exec();
        res.json(cities);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

app.get("/api/trips", async (req, res) => {
    try {
        const trips = await Trip.find({}).exec();
        res.json(trips);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

app.post("/api/trip", async (req, res) => {
    try {
        const trip = new Trip(req.body);
        await trip.save();
        res.json(trip);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

app.put("/api/trip", async (req, res) => {
    try {
        const trip = await Trip.findOneAndUpdate(
            { _id: req.body._id },
            req.body,
            { new: true }
        ).exec();
        res.json(trip);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Add activity to a city
app.post('/api/city/:cityId/activity', async (req, res) => {
    try {
        const { cityId } = req.params;
        const activity = req.body;
        const city = await City.findByIdAndUpdate(
            cityId,
            { $push: { activities: activity } },
            { new: true }
        ).exec();

        setTimeout(() => {
            res.json(city);
        }, 3000);
    } catch (e) {
        console.error(e);
        res.status(500).json({ error: e.message });
    }
});

app.get('/api/city/:cityId/activities/verify/:activityName', async (req, res) => {
    try {
        const { cityId, activityName } = req.params;
        const city = await City.findById(cityId).exec();
        
        if (!city) {
            return res.status(404).json({ message: 'City not found' });
        }

        const exists = city.activities.some(activity => activity.name === activityName);
        res.json(exists ? "The activity already exists" : "Activity does not exist");
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

app.post('/api/activity/image', upload.single('activity'), (req, res, next) => {
    try {
        //const publicPath = `http://192.168.115.108:8080/${subpath}/${req.file.originalname}`;
        const publicPath = `http://192.168.115.108:8080/public/assets/images/activities/${req.file.originalname}`;
        res.json(publicPath);
    } catch (e) {
        next(e);
    }
});

app.listen(8080, () => {
    console.log("Server is running on http://localhost:8080");
});
