import 'package:dyma_project/widgets/dyma_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripWeather extends StatelessWidget {
  final String cityName;
  final String hostBase = 'https://api.openweathermap.org/data/2.5/weather?q=';
  final String apiKey = '&appid=89471d1b502ebacc35b3aa24697d97bd';

  TripWeather({required this.cityName});

  // Construire l'URL complète pour la requête
  Uri get queryUri => Uri.parse('$hostBase$cityName$apiKey'); 

  // Récupérer les données météo
  Future<String> getWeather() async {
    try {
      final response = await http.get(queryUri);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body['weather'][0]['icon'];
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getWeather(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DymaLoader(); // Affiche le loader pendant le chargement
        } else if (snapshot.hasError || snapshot.data == 'error') {
          return Text('Erreur de chargement des données météo');
        } else if (snapshot.hasData) {
          final iconUrl = 'https://openweathermap.org/img/wn/${snapshot.data}@2x.png';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Météo', style: TextStyle(fontSize: 30)),
                Image.network(iconUrl, width: 50, height: 50), // Affiche l'image de l'icône météo
              ],
            ),
          );
        } else {
          return Text('Aucune donnée disponible');
        }
      },
    );
  }
}
