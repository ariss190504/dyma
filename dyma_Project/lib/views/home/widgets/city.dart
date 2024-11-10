import 'package:dyma_project/views/city/citys_view.dart';

import '../../../models/city_model.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {

  // final String name;
  // final String image;
  // final bool checked;
  // final VoidCallback updateChecked;

  final City city;

  CityCard({
    // required this.name,
    // required this.image,
    // this.checked = false,
    // required this.updateChecked
    required this.city
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
        child: Container(
          height: 150.0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Ink.image(
                fit: BoxFit.cover,
                image: NetworkImage(city.image?? ''),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                        '/city',
                      arguments: city.name
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.black54,
                    child: Text(
                      city.name??'',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),

    );
  }
}
