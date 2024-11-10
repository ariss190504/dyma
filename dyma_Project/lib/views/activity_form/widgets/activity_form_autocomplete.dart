import 'package:dyma_project/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future<LocationActivity> showInputAutoComplete(BuildContext context) async {
  // Show the dialog and wait for it to return a value
  final result = await showDialog<LocationActivity>(
    context: context,
    builder: (_) => const InputAddress(),
  );

  // Ensure that the result is of type LocationActivity or handle null
  return result ?? LocationActivity(address: '', latiude: null, longitude: null); // Replace with appropriate default if needed
}

class InputAddress extends StatefulWidget {
  const InputAddress({super.key});

  @override
  State<InputAddress> createState() => _InputAddressState();
}

class _InputAddressState extends State<InputAddress> {
  List<dynamic> _places = [];
  late Timer _debounce;

  Future<void> _searchAddress(String value) async {
    
    if (_debounce.isActive) _debounce.cancel();

    
    _debounce = Timer(const Duration(seconds: 1), () {
      print(value);
    });
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Address'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Rechercher',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchAddress,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (_, i) {
                var place = _places[i];
                return ListTile(
                  leading: const Icon(Icons.place),
                  title: Text(place['name'] ?? 'Unknown Place'), // Adjust according to your data structure
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}