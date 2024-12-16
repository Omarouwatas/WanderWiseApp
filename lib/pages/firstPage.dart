import 'package:flutter/material.dart';
import 'package:wise2/components/place.dart';
import 'package:wise2/pages/favorite2.dart';
import 'home.dart';
import 'profile.dart';
import 'favorites.dart';
import 'recommandation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wise2/components/globals.dart';

class FirstPage extends StatefulWidget {
  final String token; // Token passed from login

  const FirstPage({Key? key, required this.token}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  final _storage = FlutterSecureStorage();
  bool isLoading = true; 
  String? _userId;

 @override
void initState() {
  super.initState();
  _initializeData();
}

// Step 1: Initialize data
Future<void> _initializeData() async {
  try {
    // Retrieve userId from storage
    _userId = await _storage.read(key: 'id');

    if (_userId == null || _userId!.isEmpty) {
      throw Exception("User ID not found in storage.");
    }

    // Fetch data
    await fetchAllPlaces();
    await fetchFavorites(_userId!); 

    setState(() {
      _pages = [
        HomePage(),
        RecommendationsPage(),
        Favorites2(),
        ProfilePage(token: widget.token),
      ];
      isLoading = false;
    });
  } catch (e) {
    print("Error initializing data: $e");
    setState(() {
      isLoading = false;
    });
  }
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
Future<void> fetchFavorites(String userId) async {
  try {
    final url = Uri.parse('$baseUrl/favorites/ids/$userId/');
    
    // Perform the GET request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the response and fill the existing favorites list as strings
      List<String> fetchedFavorites = List<String>.from(jsonDecode(response.body).map((id) => id.toString()));

favorites.value = List<String>.from(fetchedFavorites);

    } else {
      throw Exception('Failed to fetch favorites');
    }
  } catch (e) {
    print('Error fetching favorites: $e');
  }
}

  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while fetching data
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Build UI after data is fetched
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigate,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7541B0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
