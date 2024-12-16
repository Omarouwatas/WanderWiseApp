import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wise2/components/globals.dart';
class Place {
  final String id;
  final String title;
  final double price;
  final String country;
  final String city;
  final String description;
  final List<String> facilities;
  final String image;
  final double ratings;
  final String category;

  Place({
    required this.id,
    required this.title,
    required this.price,
    required this.country,
    required this.city,
    required this.description,
    required this.facilities,
    required this.image,
    required this.ratings,
    required this.category,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'].toString(),
      title: json['title'],
      price: json['price'] is int ? json['price'].toDouble() : json['price'],
      country: json['country'],
      city: json['city'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']), 
      image: json['image'], 
      ratings: json['ratings'] is int ? json['ratings'].toDouble() : json['ratings'],
      category: json['category'],
    );
  }
}
List<Place> fetchedPlaces = [];
List<Place> localPlaces = [];


Future<List<Place>> fetchPlaces(String city) async {
  final String apiUrl = '$baseUrl/places/city/$city/'; 
  
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
    
      List<dynamic> jsonResponse = json.decode(response.body);
      fetchedPlaces = jsonResponse.map((placeJson) => Place.fromJson(placeJson)).toList();
      return jsonResponse.map((placeJson) => Place.fromJson(placeJson)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  } catch (error) {
    throw Exception('Error fetching places: $error');
  }
}

Future<Place> fetchPlaceDetails(String id) async {
  final String apiUrl = '$baseUrl/place/$id/'; 

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Place.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load place details');
    }
  } catch (error) {
    throw Exception('Error fetching place details: $error');
  }
}
Future<void> toggleFavorite(String userId, String placeId) async {
  final String apiUrl = '$baseUrl/favorites/toggle/$userId/$placeId/';
  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 201) {
      print('Added to favorites');
    } else if (response.statusCode == 200) {
      print('Removed from favorites');
    } else {
      print('Error: ${response.body}');
    }
  } catch (error) {
    print('Error toggling favorite: $error');
  }
}


Future<List<Place>> fetchAllPlaces() async {
  final String apiUrl = '$baseUrl/places/';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      // Update the global localPlaces with fetched data
      localPlaces = jsonResponse.map((placeJson) => Place.fromJson(placeJson)).toList();
      return localPlaces;
    } else {
      throw Exception('Failed to load places');
    }
  } catch (error) {
    throw Exception('Error fetching places: $error');
  }
}
  Future<List<int>> fetchFavorites(String userId) async {
    final url = Uri.parse('$baseUrl/favorites/ids/$userId/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load favorites');
    }
  }
