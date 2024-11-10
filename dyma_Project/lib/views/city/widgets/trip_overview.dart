import 'package:dyma_project/views/city/widgets/trip_overview_city.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dyma_project/models/trip_model.dart';

class TripOverview extends StatelessWidget {
  final VoidCallback setDate;
  final Trip trip;
  final String cityName;
  final String cityImage;
  final double amount;

  TripOverview(
      {required this.setDate,
      required this.trip,
      required this.cityName,
      required this.amount,
      required this.cityImage});

  @override
  Widget build(BuildContext context) {
    var orientaion = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    return Container(
      width: orientaion == Orientation.landscape
          ? size.width * 0.5
          : double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TripOverCity(
            cityName: cityName,
            cityImage: cityImage,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    trip.date != null
                        ? DateFormat('d/M/y').format(trip.date!)
                        : 'Choisissez une date',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  child: Text('Selectionner une date'),
                  onPressed: setDate,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Montant / personne',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  '$amount \$',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
