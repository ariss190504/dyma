import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/views/trip/widgets/trip_actiity_list.dart';
import 'package:flutter/material.dart';

class TripActivites extends StatelessWidget {
  //const TripActivites({super.key});
  final String tripId;

  TripActivites({required this.tripId});

  @override
  Widget build(BuildContext context) {
    print("Builde: TRIPACTIVITIES");
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.blue[100],
                tabs: [
                Tab(text: 'en cours',),
                Tab(text: 'Terminé',)
              ],
              ),
            ),
            Container(
              height: 600,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TripActivityList(
                    tripId: tripId,
                    filter: ActivityStatus.ongoing,
                  ),
                  TripActivityList(
                    filter: ActivityStatus.done, tripId: '',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
