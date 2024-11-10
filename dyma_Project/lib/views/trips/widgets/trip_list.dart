import 'package:dyma_project/views/trip/trip_view.dart';
import 'package:intl/intl.dart';

import '../../../models/trip_model.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  //const TripList({super.key});

  final List<Trip> trips;
  TripList({required this.trips});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, i){
          var trip = trips[i];
          return ListTile(
            title: Text(trip.city!),
            subtitle: trip.date != null? Text(DateFormat("d/M/y").format(trip.date!)) : null,
            trailing: Icon(Icons.info),
            onTap: (){
              Navigator.pushNamed(context, TripView.routeName,  arguments: {
                'tripId': trip.id,
                'cityName': trip.city,
              });
            },
          );
        },
      itemCount: trips.length,
    );
  }
}
