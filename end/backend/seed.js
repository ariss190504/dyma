const mongoose = require('mongoose');
const City = require("./models/city.model");

mongoose.connect('mongodb+srv://jean:123@cluster0.i28ak.mongodb.net/dymatrip?retryWrites=true&w=majority&appName=Cluster0')
    .then(() => {
        Promise.all([
            new City({
                image: '/assets/images/paris.jpeg',
                name: 'Paris',
                activities: [
                    {
                        name: 'Louvre',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a1',
                        city: 'Paris',
                        price: 12.00
                    },
                    {
                        name: 'Chaumont',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a2',
                        city: 'Paris',
                        price: 17.00,
                        // status: 'done' // Replace ActivityStatus.done with a string or define ActivityStatus
                    },
                    {
                        name: 'Notre Dame',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a3',
                        city: 'Paris',
                        price: 11.00
                    },
                    {
                        name: 'La Defense',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a4',
                        city: 'Paris',
                        price: 13.00
                    },
                    {
                        name: 'Tour Eiffel',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a5',
                        city: 'Paris',
                        price: 8.00
                    },
                    {
                        name: 'Jardin Luxembourg',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a6',
                        city: 'Paris',
                        price: 12.00
                    },
                    {
                        name: 'Velodrome',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a7',
                        city: 'Paris',
                        price: 10.00
                    },
                    {
                        name: 'Saint Tropez',
                        image: '/assets/images/activities/paris.jpeg',
                        id: 'a8',
                        city: 'Paris',
                        price: 5.00
                    },
                ],
            }).save(),

            new City({
                image: 'http://192.168.115.108/assets/images/lyon.jpeg',
                name: 'Lyon',
                activities: [
                    {
                        name: 'Louvre',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'l1',
                        city: 'Lyon',
                        price: 12.00
                    },
                    {
                        name: 'Chaumont',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'l2',
                        city: 'Lyon',
                        price: 17.00
                    },
                    {
                        name: 'Notre Dame',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'l3',
                        city: 'Lyon',
                        price: 11.00
                    },
                    {
                        name: 'La Defense',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'l4',
                        city: 'Lyon',
                        price: 13.00
                    },
                ],
            }).save(),

            new City({
                image: 'http://192.168.115.108/assets/images/monaco.jpeg',
                name: 'Monaco',
                activities: [
                    {
                        name: 'Louvre',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'm1',
                        city: 'Monaco',
                        price: 12.00
                    },
                    {
                        name: 'Chaumont',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'm2',
                        city: 'Monaco',
                        price: 17.00,
                        status: 'done'
                    },
                    {
                        name: 'Notre Dame',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'm3',
                        city: 'Monaco',
                        price: 11.00
                    },
                    {
                        name: 'La Defense',
                        image: 'http://192.168.115.108/assets/images/activities/paris.jpeg',
                        id: 'm4',
                        city: 'Monaco',
                        price: 13.00
                    },
                ],
            }).save()
        ]).then(() => {
            console.log("Cities with activities have been added successfully!");
            mongoose.connection.close();
        }).catch((error) => {
            console.error("Error adding cities with activities:", error);
            mongoose.connection.close();
        });
    });
