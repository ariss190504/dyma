import '../../../models/activity_model.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  //const ActivityCard ({super.key});
  final Activity activity;
  final bool isSelected;
  final Function toggleActivity;
  
  ActivityCard({required this.activity, required this.isSelected, required this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink.image(
            image: NetworkImage(activity.image??''),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () => toggleActivity(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(isSelected)
                      Icon(Icons.check, size: 20, color: Colors.white,)
                  ],
                ),),
                Row(
                  children: [
                    Flexible(child:
                        FittedBox(
                          child: Text(
                            activity.name??'',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
