import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TripOverCity extends StatelessWidget {
  //const TripOverCity({super.key});

  final String cityName;
  final String cityImage;

  TripOverCity({required this.cityName, required this.cityImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Hero(
            tag: cityName,
            child: Image.network(
              cityImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black45,
          ),
          Center(
            child: Text(
              cityName,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
