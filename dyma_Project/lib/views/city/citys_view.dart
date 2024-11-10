import 'package:dyma_project/providers/city_provider.dart';
import 'package:dyma_project/providers/trip_provider.dart';
import 'package:dyma_project/views/city/widgets/activity_list.dart';
import 'package:dyma_project/views/city/widgets/trip_activity_list.dart';
import 'package:dyma_project/views/city/widgets/trip_overview.dart';
import 'package:dyma_project/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dyma_project/widgets/dyma_drawer.dart';
import 'package:dyma_project/models/city_model.dart';
import 'package:dyma_project/models/trip_model.dart';
import 'package:dyma_project/models/activity_model.dart';

class CitysView extends StatefulWidget {
  static const String routeName = '/city';

  Widget showContext(
      {required BuildContext context, required List<Widget> children}) {
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          )
        : Column(children: children);
  }

  @override
  State<CitysView> createState() => _CitysState();
}

class _CitysState extends State<CitysView> with WidgetsBindingObserver {
  late Trip myTrip;
  late int index;

  double get amount {
    return myTrip.activities.fold(0.0, (previousValue, element) {
      return previousValue + element.price;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    index = 0;
    myTrip = Trip(city: null, activities: [], date: null, id: '');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void toggleActivity(Activity activity) {
    setState(() {
      myTrip.activities.contains(activity)
          ? myTrip.activities.remove(activity)
          : myTrip.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      myTrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('voulez vous sauvegarder'),
          contentPadding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                    child: Text('annuler')),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'save');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Sauvegarder',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        );
      },
    );

    if (myTrip.date == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('attention !'),
            content: Text('vous n\'avez pas entré de date'),
            actions: [
              TextButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else if (result == 'save') {
      myTrip.city = cityName;
      print(
          "Ajout du voyage pour la ville: $cityName avec ${myTrip.activities.length} activités.");
      Provider.of<TripProvider>(context, listen: false).addTrip(myTrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          myTrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    //String cityName = ModalRoute.of(context)?.settings.arguments as String;
    final cityName = ModalRoute.of(context)?.settings.arguments as String?;
    // if (cityName == null) {
    //   return Scaffold(
    //     appBar: AppBar(title: Text('Organisation de voyage')),
    //     body: Center(child: Text('Aucune ville sélectionnée')),
    //   );
    // }
    final city = Provider.of<CityProvider>(context).getCityByName(cityName!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Organisation de voyage'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/activity-form',
                  arguments: cityName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: DymaDrawer(),
      body: Container(
        child: widget.showContext(
          context: context,
          children: [
            TripOverview(
              cityName: city.name,
              setDate: setDate,
              trip: myTrip,
              amount: amount,
              cityImage: city.image,
            ),
            Expanded(
              child: index == 0
                  ? ActivityList(
                      activities: city.activities,
                      selectedActivities: myTrip.activities,
                      toggleActivity: toggleActivity,
                    )
                  : TripActivityList(
                      activities: myTrip.activities,
                      deleteTripActivity: deleteTripActivity,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: () {
          saveTrip(city.name ?? '');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Découverte'),
          BottomNavigationBarItem(
              icon: Icon(Icons.stars), label: 'Mes activités'),
        ],
        onTap: switchIndex,
      ),
    );
  }
}
