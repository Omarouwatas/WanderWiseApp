import 'package:flutter/material.dart';
import 'globals.dart'; // Import the global favorites list
import 'place.dart'; // Import the Place class and places list

class DetailsPage extends StatefulWidget {
  final String id; // Receive only the id of the place

  DetailsPage({required this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;
  late Place place;

  @override
  void initState() {
    super.initState();
    place = places.firstWhere((place) => place.id == widget.id);
    isFavorite = favorites.contains(widget.id);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
 
        favorites.remove(widget.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${place.title} has been removed from favorites.')),
        );
      } else {
        favorites.add(widget.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${place.title} has been added to favorites.')),
        );
      }
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            // Main Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                place.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Title and Price
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
                  // Rating Stars
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
            // Add to Favorites and Comment Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: toggleFavorite,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFavorite ? Colors.red : Colors.purple,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      isFavorite
                          ? 'Remove from Favorites'
                          : 'Add to Favorites',
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

  // Facility Card Widget
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

  // Map facility names to icons
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
      default:
        return Icons.help_outline;
    }
  }
}
