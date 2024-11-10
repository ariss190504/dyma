import 'package:dyma_project/models/city_model.dart';
import 'package:dyma_project/models/trip_model.dart';
import 'package:dyma_project/providers/city_provider.dart';
import 'package:dyma_project/providers/trip_provider.dart';
import 'package:dyma_project/views/trip/widgets/trip_activities.dart';
import 'package:dyma_project/views/trip/widgets/trip_city_bar.dart';
import 'package:dyma_project/views/trip/widgets/trip_weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripView extends StatelessWidget {
  static const String routeName = '/trip';

  @override
  Widget build(BuildContext context) {
    print("Builder");
    // Récupérer les arguments de la route
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;

    if (args == null || args['cityName'] == null || args['tripId'] == null) {
      // Si les arguments ou certaines clés sont null, afficher un message d'erreur ou une page par défaut
      return Scaffold(
        body: Center(
          child: Text('Erreur: Aucune donnée de voyage trouvée ou données manquantes.'),
        ),
      );
    }

    final String cityName = args['cityName'] ?? '';
    final String tripId = args['tripId'] ?? '';

    // Récupérer la ville et le voyage à partir des providers
    final city = Provider.of<CityProvider>(context, listen: false).getCityByName(cityName);
    // final trip = Provider.of<TripProvider>(context).getById(tripId);

    // Vérification si la ville ou le voyage n'ont pas été trouvés
    if (city == null) {
      return Scaffold(
        body: Center(
          child: Text('Erreur: Ville ou voyage non trouvé.'),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TripCityBar(city: city),
              TripWeather(cityName: cityName,),
              TripActivites(
                tripId: tripId
                  // activities: trip.activities
              ),
            ],
          ),
        ),
      ),
    );
  }
}
