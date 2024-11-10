
import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/providers/city_provider.dart';
import 'package:dyma_project/providers/trip_provider.dart';
import 'package:dyma_project/models/trip_model.dart';
import 'package:dyma_project/models/city_model.dart';
import 'package:dyma_project/views/404/not_found.dart';
import 'package:dyma_project/views/activity_form/activity_form.dart';
import 'package:dyma_project/views/city/citys_view.dart';
import 'package:dyma_project/views/home/home_view.dart';
import 'package:dyma_project/views/trip/trip_view.dart';
import 'package:dyma_project/views/trips/trips_view.dart';
import 'package:dyma_project/widgets/data.dart' as data;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main(){
  runApp(DymaTrip());
}

class DymaTrip extends StatefulWidget{
  @override
  _DymaTripState createState() => _DymaTripState();
}
class _DymaTripState extends State<DymaTrip>{

  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: cityProvider
        ),
        ChangeNotifierProvider.value(
          value: tripProvider
        )
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (_)=> HomeView(),
            CitysView.routeName: (_) => CitysView(),
            TripsView.routeName: (_) => TripsView(),
            TripView.routeName: (_) => TripView(),
            ActivityFormView.routeName: (_) => ActivityFormView()
          },
          onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => NotFound())
        ),
      );
  }
}