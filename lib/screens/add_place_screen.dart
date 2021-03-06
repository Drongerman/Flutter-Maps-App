import 'package:flutter/material.dart';
import 'package:maps_app/models/place.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = new TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
    );
  }

  void _savePlace(BuildContext context) {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              return SizedBox(
                height: 60,
                child: RaisedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add Place'),
                  onPressed: () {
                    _savePlace(context);
                  },
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Theme.of(context).accentColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
