import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';
import './activity_card.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final List<Activity> selectedActivities;
  final Function toggleActivity;

  ActivityList({required this.activities, required this.selectedActivities, required this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        crossAxisCount: 2,
        //liste des elements a afficher
        children:
        activities.map((activity) => ActivityCard(
            activity: activity,
          isSelected: selectedActivities.contains(activity),
            toggleActivity: () {
            toggleActivity(activity);
          }
        ),
        ).toList(),
    );
  }
}
