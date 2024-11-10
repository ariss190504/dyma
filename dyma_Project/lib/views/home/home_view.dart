import 'package:dyma_project/providers/city_provider.dart';
import 'package:dyma_project/views/home/home_view.dart';
import 'package:dyma_project/widgets/dyma_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:dyma_project/widgets/dyma_drawer.dart';
import 'package:dyma_project/widgets/ask_modal.dart';
import 'package:dyma_project/models/city_model.dart';
import 'package:dyma_project/views/home/widgets/city.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  // void switchChecked(city){
  //   var index = cities.indexOf(city);
  //   setState(() {
  //     cities[index]['checked'] = !cities[index]['checked'];
  //   });
  // }

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // openModal(context) {
  //   askModal(context, 'Hello veux tu quelques chose?').then((result) {
  //     print(result);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    List<City> filteredCities =
        cityProvider.getFilteredCities(searchController.text);

    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.home),
        title: Text('Dyma Trip'),
        actions: [Icon(Icons.more_vert)],
      ),
      drawer: DymaDrawer(),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'rechercher une ville',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                ],
              )),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: RefreshIndicator(
                  onRefresh: Provider.of<CityProvider>(context).fetchData,
                  child: cityProvider.isLoading
                      ? DymaLoader() : filteredCities.length > 0 ? ListView.builder(
                          itemCount: filteredCities.length,
                          itemBuilder: (_, i) {
                            return CityCard(
                              city: filteredCities[i],
                            );
                          },
                  ): Text('aucun resultat') ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
