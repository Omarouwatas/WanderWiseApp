import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wise2/components/details.dart';
import 'package:wise2/components/globals.dart';  // Import global places data
import 'package:wise2/components/place.dart';

class Favorites extends StatefulWidget {
  final String token;

  Favorites({required this.token});

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Future<List<int>>? _favoritesFuture; 
  String? _userId;
  List<Place> favoritePlaces = [];
  bool _hasFetchedPlaces = false; 

  @override
  void initState() {
    super.initState();
    fetchUserProfile(widget.token).then((profile) {
      setState(() {
        _userId = profile['id'].toString();
        _favoritesFuture = fetchFavorites(_userId!);
        

      });
    }).catchError((error) {
      print('Error fetching user profile: $error');
    });
  }


  Future<Map<String, dynamic>> fetchUserProfile(String token) async {
    final url = Uri.parse('$baseUrl/profile/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
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

  // Fetch place details only once for each place ID
  Future<void> fetchPlaceDetails(List<int> favoriteIds) async {
    List<Future> requests = [];
    for (var id in favoriteIds) {
      requests.add(http.get(Uri.parse('$baseUrl/place/$id/')).then((response) {
        if (response.statusCode == 200) {
          final placeData = jsonDecode(response.body);
          setState(() {
            favoritePlaces.add(Place.fromJson(placeData)); 
          });
        } else {
          print("Failed to load place details for $id");
        }
      }));
    }
    

    await Future.wait(requests);
    setState(() {
      _hasFetchedPlaces = true; 
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final cardWidth = (screenWidth - 48) / 2; // Calculate card width (16 padding * 2 + spacing)
    final cardHeight = cardWidth + 80;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<int>>(
          future: _favoritesFuture,  
        
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No favorites found.'));
            } else {
              final favoriteIds = snapshot.data!;  
              
              if (!_hasFetchedPlaces) {
                fetchPlaceDetails(favoriteIds);  
              }
        
        
              return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10, 
                          childAspectRatio: 0.8, 
                        ),
                itemCount: favoritePlaces.length,
                itemBuilder: (context, index) {
                  final favorite = favoritePlaces[index];
                  favorites.value.add(favorite.id.toString());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(id: favorite.id),
                        ),
                      );
                    },
                    child: _buildFavoriteCard(
                      title: favorite.title,
                      imagePath: favorite.image,
                      price: favorite.city,
                      cardWidth: cardWidth,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }Widget _buildFavoriteCard({
  required String title,
  required String imagePath,
  required String price,
  required double cardWidth,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final cardWidth = constraints.maxWidth; // Largeur dynamique
      final cardHeight = cardWidth * 1.2;     // Hauteur proportionnelle

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imagePath,
                height: cardHeight * 0.6, 
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: cardHeight * 0.6,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.error, color: Colors.red, size: 40),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    price,
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
