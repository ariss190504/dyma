import 'dart:math';

import 'package:dyma_project/models/activity_model.dart';
import 'package:flutter/material.dart';

class TripActivityCard extends StatefulWidget {
  //const TripActivityCard({super.key});
  final Activity activity;
  final Function deleteTripActivity;

  Color getColor(){
    const colors = [Colors.blue, Colors.red];
    return colors[Random().nextInt(2)];
  }

  TripActivityCard({required Key key, required this.activity, required this.deleteTripActivity}): super(key: key);

  @override
  State<TripActivityCard> createState() => _TripActivityCardState();
}

class _TripActivityCardState extends State<TripActivityCard> {

  late Color color;

  @override
  void initState() {
    color = widget.getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.activity.image??''),
        ),
        title: Text(
            widget.activity.name??'',
            style: TextStyle(
                color: color
            )
        ),
        subtitle: Text(widget.activity.city??''),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: (){
            widget.deleteTripActivity(widget.activity.id);
          },
        ),
      ),
    );
  }
}
