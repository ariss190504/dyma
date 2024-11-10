
import '../../../models/activity_model.dart';
import 'package:dyma_project/views/city/widgets/trip_activity_card.dart';
import 'package:flutter/material.dart';

class TripActivityList extends StatelessWidget {
  //const TripActivityList({super.key});

  final List<Activity> activities;
  final Function deleteTripActivity;

  TripActivityList({required this.activities, required this.deleteTripActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index){
          var activity = activities[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(activity.image??''),
              ),
              title: Text(activity.name??''),
              subtitle: Text(activity.city??''),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ), onPressed: () {
                  deleteTripActivity(activity.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Activité supprimée'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Annuler',
                        onPressed: () {
                          print('Annulation');
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  );
              },
              ),
            ),
          );
        },
        itemCount: activities.length,
      ),
    );
  }
}
//     children:
//       // var activity = activities[index];
//     activities.map(
//     (activity) => TripActivityCard(
//     key: ValueKey(activity.id),
//     activity: activity,
//     deleteTripActivity: deleteTripActivity,
//   ),
// ).toList()),
