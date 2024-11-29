import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart'; // Importez la classe DetailsPage
import 'package:wise2/components/place.dart'; // Importez la classe Place

class RecommendationsPage extends StatelessWidget {
  // Liste des recommandations sous forme d'objets Place
  final List<Place> recommendations = [
    Place(
      id: '1',
      title: 'Explore Aspen',
      price: 4199.0,
      country: 'USA',
      description: 'Discover the beauty of Aspen, a serene alpine town.',
      facilities: ['WiFi', 'Pool', 'Spa'],
      image: 'images/aspen1.jpg',
    ),
    Place(
      id: '2',
      title: 'Luxurious Aspen',
      price: 7299.0,
      country: 'USA',
      description: 'Experience luxury at its best in Aspen.',
      facilities: ['WiFi', 'Gym', 'Bar'],
      image: 'images/aspen2.jpg',
    ),
    Place(
      id: '3',
      title: 'Mountain Retreat',
      price: 5499.0,
      country: 'Canada',
      description: 'Relax in the serene mountains of Canada.',
      facilities: ['WiFi', 'Hiking Trails', 'Fireplace'],
      image: 'images/aspen3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WanderWise',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Text(
              'Recommendations',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final place = recommendations[index];
                  return GestureDetector(
                    onTap: () {
                      // Naviguer vers la page de détails en transmettant un objet Place
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(place: place), // Transmettez l'objet
                        ),
                      );
                    },
                    child: _buildRecommendationCard(
                      title: place.title,
                      price: '\$${place.price.toStringAsFixed(2)}',
                      imagePath: place.image,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour la carte de recommandation
  Widget _buildRecommendationCard({
    required String title,
    required String price,
    required String imagePath,
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
