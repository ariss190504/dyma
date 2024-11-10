import 'dart:collection';
import 'dart:io';
import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/models/city_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityProvider with ChangeNotifier {
  final String host = 'http://192.168.115.108:8080';
  List<City> _cities = [];
  bool _isLoading = false;

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);

  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  UnmodifiableListView<City> getFilteredCities(String filter) =>
      UnmodifiableListView(
        _cities
            .where(
              (city) =>
                  city.name!.toLowerCase().startsWith(filter.toLowerCase()),
            )
            .toList(),
      );

  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners(); // Notify before starting the fetch

    try {
      final Uri url = Uri.parse('$host/api/cities');
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        _cities = (jsonDecode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        // Handle other status codes
        print('Failed to load cities. Status code: ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addActivity(Activity newActivity) async {
    try {
      String? cityId = getCityByName(newActivity.city ?? '').id;

      if (cityId == null) {
        print('City ID not found for city: ${newActivity.city}');
        return;
      }

      final Uri url = Uri.parse('$host/api/city/$cityId/activity');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newActivity.toJson()),
      );

      if (response.statusCode == 200) {
        int index = cities.indexWhere((city) => city.id == cityId);
        _cities[index] = City.fromJson(
          json.decode(response.body),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyIsActivityNameIsUnique(
      String cityName, String activityName) async {
    try {
      City city = getCityByName(cityName);
      http.Response response = await http.get(
          '$host/api/city/${city.id}/activities/verify/$activityName' as Uri);
      if (response.body != null) {
        return json.decode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage(File pickedImage) async{
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$host/api/activity/image'),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'activity',
          pickedImage.readAsBytesSync(),
          filename: basename(pickedImage.path),
          contentType: MediaType('multipart', 'form-data'),
        ),
      );
      var response = await request.send();
      if(response.statusCode == 200){
        var responseData = await response.stream.toBytes();
        print(responseData);
        return json.decode(String.fromCharCode(responseData as int));
      }else{
        throw 'error';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
