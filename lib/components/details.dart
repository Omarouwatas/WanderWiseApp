import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wise2/pages/listComment.dart';
import 'globals.dart'; // Import the global favorites list
import 'place.dart'; // Import the Place class and places list
import 'package:wise2/pages/comments.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  
  DetailsPage({required this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;
  late Place place;
  bool isLoading = true; 
final FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    
      setState(() {
        place = localPlaces.firstWhere((place) => place.id == widget.id);
        isFavorite = favorites.value.contains(widget.id);
        isLoading = false; 
      });
  }

  Future<void> fetchAllPlaces() async {
    final String apiUrl = '$baseUrl/places/'; 

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        localPlaces = jsonResponse.map((placeJson) => Place.fromJson(placeJson)).toList();
        print('Fetched ${localPlaces.length} places.');
      } else {
        throw Exception('Failed to fetch places: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching places: $error');
    }
  }


Future<void> toggleFavorite(String placeId) async {
  try {

    String? userId = await _storage.read(key: 'id');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not found. Please log in again.')),
      );
      return;
    }

    final url = Uri.parse('$baseUrl/favorites/toggle/$userId/$placeId/'); 
    final response = await http.post(url);

    if (response.statusCode == 201) {
      setState(() {
        isFavorite = true;
        favorites.value = List.from(favorites.value)..add(placeId.toString());
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to favorites')),
      );
    } else if (response.statusCode == 200) {
      setState(() {
        isFavorite = false;
        favorites.value = List.from(favorites.value)..remove(placeId.toString());
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Removed from favorites')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to toggle favorite. Error: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          place.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                place.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.error, size: 50, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${place.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < place.ratings.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    place.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Facilities Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Facilities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: place.facilities.map((facility) {
                  return _buildFacilityCard(
                    icon: _getFacilityIcon(facility),
                    label: facility,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => OpinionPage(id: widget.id), 
  ),
);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 117, 65, 176),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Add a comment or give a rating',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
    toggleFavorite(widget.id); 
  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isFavorite ? Colors.red : const Color.fromARGB(255, 117, 65, 176),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityCard({required IconData icon, required String label}) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.grey[600]),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getFacilityIcon(String facility) {
    switch (facility) {
      case 'WiFi':
        return Icons.wifi;
      case 'Dinner':
        return Icons.restaurant;
      case '1 Tub':
        return Icons.bathtub;
      case 'Pool':
        return Icons.pool;
      case 'Bar':
        return Icons.local_bar;
      case 'Nature Trails':
        return Icons.nature;
      case 'Meeting Rooms':
        return Icons.room;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Free WiFi':
        return Icons.wifi;
      case 'Nature Trails':
        return Icons.nature;
      case 'Fitness Center':
        return Icons.fitness_center;
      case 'Room Service':
        return Icons.room_service;
      case 'Spa':
        return Icons.spa;
      case 'Fine Dining':
        return Icons.dining;
      case 'Traditional cuisine':
        return Icons.restaurant;
      case 'Wine Selection':
        return Icons.wine_bar;
      default:
        return Icons.help_outline;
    }
  }
}
