import 'package:dyma_project/views/activity_form/widgets/activity_form.dart';
import 'package:dyma_project/widgets/dyma_drawer.dart';
import 'package:flutter/material.dart';

class ActivityFormView extends StatelessWidget {
  static const String routeName = '/activity-form';
  const ActivityFormView({super.key});

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouté une activité'),
      ),
      drawer: DymaDrawer(),
      body: SingleChildScrollView(
        child: ActivityForm(cityName: cityName),
      ),
    );
  }
}
