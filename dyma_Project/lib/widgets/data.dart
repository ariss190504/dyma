// import '../models/activity_model.dart';
// import 'package:flutter/material.dart';
// import '../datas/data.dart' as data;
//
// class Data extends InheritedWidget {
//
//   final List<Activity> activities = data.activities ;
//   Data({required Widget child}): super(child: child);
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // a pour role de modifier quand un widget enfant va prendre les proprites du widget parent
//     return true;
//   }
//
//   static of(BuildContext context){
//     return context.dependOnInheritedWidgetOfExactType<Data>();
//   }
// }