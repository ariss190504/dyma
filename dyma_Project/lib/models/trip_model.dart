import 'package:dyma_project/models/activity_model.dart';
import 'package:flutter/material.dart';

class Trip {
  String id;
  String? city;
  List<Activity> activities;
  DateTime? date;

  Trip({
    required this.city,
    required this.activities,
    required this.date,
    required this.id,
  });

  // methode qui permet de creer un trip a partir d'un JSON
  Trip.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        city = json['city'],
        date = DateTime.parse(json['date']),
        activities = (json['activities'] as List)
            .map((activityJson) => Activity.fromJson(activityJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'city': city,
      'date': date?.toIso8601String(),
      'activities': activities
          .map(
            (activity) => activity.toJson(),
          )
          .toList(),
    };
  }
}
