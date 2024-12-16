import 'package:flutter/foundation.dart';

ValueNotifier<List<String>> favorites = ValueNotifier<List<String>>([]);

final Map<String, List<String>> countriesAndCities = {
    'France': ['Paris', 'Lyon', 'Marseille'],
    'Spain': ['Madrid', 'Barcelona', 'Seville'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal'],
    'Greece': ['Mykonos', 'Santorini', 'Atenes'],
    'Italy': ['Rome', 'Milan', 'Naples'],
    'Tunisia': ['Tunis', 'Monastir', 'Djerba'],
  };

const String baseUrl = 'http://127.0.0.1:8000/api';
