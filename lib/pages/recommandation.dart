import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart'; // Import the DetailsPage class
import 'package:wise2/components/place.dart'; // Import the Place class

class RecommendationsPage extends StatelessWidget {
  // List of recommendations as Place objects
  final List<Place> recommendations = [
  Place(
    id: '1',
    title: 'Coeurdes Alpes',
    price: 6299.0,
    country: 'France',
    city: 'Chamonix',
    description: 'A beautiful alpine resort in the heart of France.',
    facilities: ['WiFi', 'Pool', 'Spa'],
    image: 'images/fav1.jpg',
    ratings: 4.8,
    category: 'Hotel',
  ),
  Place(
    id: '2',
    title: 'Beach Stone',
    price: 6299.0,
    country: 'France',
    city: 'Nice',
    description: 'A serene beach getaway with stunning views.',
    facilities: ['WiFi', 'Beach Access', 'Bar'],
    image: 'images/fav2.jpg',
    ratings: 4.5,
    category: 'Adventure',
  ),
  Place(
    id: '3',
    title: 'Isle Of Pines',
    price: 6299.0,
    country: 'Italy',
    city: 'Venice',
    description: 'A beautiful island with breathtaking scenery.',
    facilities: ['WiFi', 'Luxury Rooms', 'Private Tours'],
    image: 'images/fav3.jpg',
    ratings: 4.6,
    category: 'Hotel',
  ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final cardWidth = (screenWidth - 48) / 2; // Calculate card width (16 padding * 2 + spacing)
    final cardHeight = cardWidth + 80; // Card height (Image + Text area)

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16, 
            mainAxisSpacing: 16, 
            childAspectRatio: cardWidth / cardHeight, 
          ),
          
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final place = recommendations[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(id: place.id),
                  ),
                );
              },
              child: _buildRecommendationCard(
                title: place.title,
                price: '\$${place.price.toStringAsFixed(2)}',
                imagePath: place.image,
                cardWidth: cardWidth,
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget for a recommendation card
  Widget _buildRecommendationCard({
    required String title,
    required String price,
    required String imagePath,
    required double cardWidth,
  }) {
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
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: cardWidth, // Image height proportional to card width
              width: double.infinity, // Take full width of the card
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: cardWidth,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.error, color: Colors.red, size: 40),
                  ),
                );
              },
            ),
          ),
          // Text section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1, // Limit the title to one line
                  overflow: TextOverflow.ellipsis, // Add "..." if text overflows
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
  }
}
