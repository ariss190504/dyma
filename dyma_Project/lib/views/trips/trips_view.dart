import 'package:dyma_project/providers/trip_provider.dart';
import 'package:dyma_project/views/trips/widgets/trip_list.dart';
import 'package:dyma_project/widgets/dyma_loader.dart';
import 'package:provider/provider.dart';
import '../../models/trip_model.dart';
import '../../widgets/dyma_drawer.dart';
import 'package:flutter/material.dart';

class TripsView extends StatelessWidget {
  static const String routeName = '/trips';
  @override
  Widget build(BuildContext context) {
    // Récupérer la liste des voyages depuis le provider
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    // Convertir UnmodifiableListView en List<Trip>

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mes Voyages'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'A venir'),
              Tab(text: 'Passé'),
            ],
          ),
        ),
        drawer: DymaDrawer(),
        body: tripProvider.isLoading != true
            ? tripProvider.trips.length > 0
                ? TabBarView(
                    children: [
                      TripList(
                        trips: tripProvider.trips
                            .where(
                                (trip) => DateTime.now().isBefore(trip.date!))
                            .toList(),
                      ),
                      TripList(
                        trips: tripProvider.trips
                            .where((trip) => DateTime.now().isAfter(trip.date!))
                            .toList(),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text('aucun voyage pour le moment'),
                  )
            : DymaLoader(),
      ),
    );
  }
}
