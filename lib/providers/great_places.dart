import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: PlaceLocation(latitude: 0, longitude: 1),
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
