import 'package:dyma_project/models/city_model.dart';
import 'package:flutter/material.dart';

class TripCityBar extends StatelessWidget {
  final City city;

  TripCityBar({required this.city});

  @override
  Widget build(BuildContext context) {
    print("Builde: TRIPCITYBAR");
    return Container(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.network(
            city.image??'',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black38,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    city.name??'',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
