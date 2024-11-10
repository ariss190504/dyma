import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/models/trip_model.dart';
import 'package:dyma_project/providers/trip_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripActivityList extends StatelessWidget {
  //const TripActivityList({super.key});

  final String tripId;
  final ActivityStatus filter;

  TripActivityList({required this.filter, required this.tripId});

  @override
  Widget build(BuildContext context) {
    print("Builde: TRIPACTIVITYLIST");

    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final Trip trip = Provider.of<TripProvider>(context).getById(tripId);
        final List<Activity> activities = trip.activities
            .where((activity) => activity.status == filter)
            .toList();
        return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, i) {
            Activity activity = activities[i];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: filter == ActivityStatus.ongoing
                  ? Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      key: ValueKey(activity.id),
                      child: Text(''),
                      confirmDismiss: (_) {
                        return Provider.of<TripProvider>(context, listen: false)
                            .updateTrip(trip, activity.id??'')
                            .then((_) => true)
                            .catchError((_) => false);
                      },
                      // onDismissed: (_) {
                      //   print('dismissed');

                      // },
                    )
                  : Card(
                      child: ListTile(
                        title: Text(
                          activity.name??'',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
            );
          },
        );
      },
      child: Text('123'),
    );
  }
}
