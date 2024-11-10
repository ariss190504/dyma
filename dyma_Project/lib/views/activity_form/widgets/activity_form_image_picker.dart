import 'dart:io';

import 'package:dyma_project/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  //const ActivityFormImagePicker({super.key});
  final Function updateUrl;

  ActivityFormImagePicker({required this.updateUrl});
  @override
  State<ActivityFormImagePicker> createState() =>
      _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {

  File? _deviceImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? pickedFile = await imagePicker.pickImage(source: source);
      
      if (pickedFile != null) {
        // Avoiding name conflict with 'Context'
        final url = await Provider.of<CityProvider>(context as BuildContext, listen: false).uploadImage(File(pickedFile.path));
        print('url final $url');
        widget.updateUrl(url);
        setState(() {
          _deviceImage = File(pickedFile.path);
        });
        print('Image selected successfully');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('An error occurred while picking an image: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () =>_pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo),
                label: Text('Galerie'),
              ),
              TextButton.icon(
                onPressed: () =>_pickImage(ImageSource.camera),
                icon: Icon(Icons.photo_camera),
                label: Text('Camera'),
              ),
            ],
          ),
          Container(width: double.infinity,child: _deviceImage != null ? Image.file(_deviceImage!): Text('Aucune Image'),)
        ],
      ),
    );
  }
}
