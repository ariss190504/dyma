
import 'package:dyma_project/views/city/citys_view.dart';
import '../views/trips/trips_view.dart';
import '../views/home/home_view.dart';
import 'package:flutter/material.dart';

class DymaDrawer extends StatelessWidget {
  const DymaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('DymaTrip',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
              ),
            ),
            decoration: BoxDecoration(gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: (){
              Navigator.pushNamed(context, HomeView.routeName);
            },
          ),
          Divider(
            color: Colors.grey[600],
          ),
          ListTile(
            leading: Icon(Icons.flight),
            title: Text('Mes Voyages'),
            onTap: (){
              Navigator.pushNamed(
                context,
                TripsView.routeName,
                  // Si trips est null, une liste vide est passée
              );
            },
          ),
        ],
      ),
    );
  }
}
