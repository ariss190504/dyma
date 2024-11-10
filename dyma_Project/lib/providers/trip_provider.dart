import 'dart:collection';
import 'dart:io';

import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/models/trip_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class TripProvider with ChangeNotifier {
  final String host = 'http://192.168.115.108:8080';
  List<Trip> _trips = [];
  bool isLoading = false;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  Future<void> fetchData() async {
    try {
      isLoading = true;
      Uri url = Uri.parse('$host/api/trips');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        _trips = (jsonDecode(response.body) as List)
            .map((tripJson) => Trip.fromJson(tripJson))
            .toList();
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<void> addTrip(Trip trip) async {
    try {
      Uri url = Uri.parse('$host/api/trips');
      http.Response response = await http.post(
        url,
        body: json.encode(
          trip.toJson(),
        ),
        headers: {'content-type': 'applictaion/json'},
      );
      if (response.statusCode == 200) {
        _trips.add(
          Trip.fromJson(
            json.decode(response.body),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTrip(Trip trip, String activityId) async {
    try {
      Uri url = Uri.parse('$host/api/trip');

      Activity activity = trip.activities
          .firstWhere((activity) => activity.id == activityId);
          activity.status = ActivityStatus.done;

      http.Response response = await http.put(
        url,
        body: json.encode(
          trip.toJson(),
        ),
        headers: {'content-type' : 'application/json'},
      );
      if(response.statusCode != 200){
        activity.status= ActivityStatus.ongoing;
        throw HttpException('error');
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Trip getById(String tripId) {
    return trips.firstWhere((trip) => trip.id == tripId);
  }
}
