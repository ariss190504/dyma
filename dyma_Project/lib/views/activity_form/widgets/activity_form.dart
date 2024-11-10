import 'package:dyma_project/models/activity_model.dart';
import 'package:dyma_project/providers/city_provider.dart';
import 'package:dyma_project/views/activity_form/widgets/activity_form_autocomplete.dart';
import 'package:dyma_project/views/activity_form/widgets/activity_form_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivityForm extends StatefulWidget {
  final String cityName;

  const ActivityForm({Key? key, required this.cityName}) : super(key: key);

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  // GlobalKey permet de recuperer la reference d'un widget
  //FormState est le widget qui est crée par le widget Form
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late Activity _newActivity;
  late FocusNode _priceFocusNode;
  late FocusNode _addressFocusNode;
  late FocusNode _urlFocusNode;
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  late String nameInputAsync;

  @override
  void initState() {
    super.initState();
    _newActivity = Activity(
      city: widget.cityName,
      name: null,
      price: 0,
      image: null,
      status: ActivityStatus.ongoing, 
      location: LocationActivity(address: null, longitude: null, latiude: null),
    );
    _priceFocusNode = FocusNode();
    _urlFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _addressFocusNode.addListener(() async{
      if(_addressFocusNode.hasFocus){
        var location = await showInputAutoComplete(context);
        print('has focus');
      }else{
        print('no focus');
      }
    });
  }

  void updateUrlField(String url){
    setState(() {
      _urlController.text = url;
    });
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _urlFocusNode.dispose();
    _addressFocusNode.dispose();
    _urlController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> submitForm() async {
    try {
      CityProvider cityProvider = Provider.of(context, listen: false);
      _formkey.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      nameInputAsync = await cityProvider.verifyIsActivityNameIsUnique(
          widget.cityName, _newActivity.name ?? '');
      if (_formkey.currentState?.validate() ?? false) {
        // Vous pouvez ici traiter _newActivity (e.g., l'envoyer à un serveur ou l'enregistrer localement)
        await cityProvider.addActivity(_newActivity);
        Navigator.pop(context);
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty)
                  return 'remplissez le nom';
                else if (nameInputAsync != null) return nameInputAsync;
                return null;
              },
              decoration: InputDecoration(labelText: 'Nom'),
              onSaved: (value) => _newActivity.name = value,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            SizedBox(height: 30),
            TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value!.isEmpty) return 'reseignez le prix';
                  return null;
                },
                decoration: InputDecoration(hintText: 'Prix'),
                onSaved: (value) => _newActivity.price = double.parse(value!),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_urlFocusNode)),
            SizedBox(height: 30),
            TextFormField(
              focusNode: _addressFocusNode,
              decoration: InputDecoration(
                hintText: 'adresse',
              ),
              onSaved: (value) => _newActivity.location.address = value!,
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.url,
              focusNode: _urlFocusNode,
              controller: _urlController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Renseignez l\'URL de l\'image';
                return null;
              },
              decoration: InputDecoration(hintText: 'URL image'),
              onSaved: (value) => _newActivity.image = value,
            ),
            SizedBox(height: 30),
            ActivityFormImagePicker(updateUrl: updateUrlField),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Annuler'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : submitForm,
                  child: Text('Sauvegarder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
