import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart';
import 'package:wise2/components/place.dart';
import 'package:wise2/components/globals.dart'; // Import the global favorites list

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
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
                  style: TextStyle(fontSize: 16, fontFamily: 'OpenSans',fontWeight: FontWeight.bold),
                ),
          
            SizedBox(height: 20),

            Row(
              children: [
                Icon(
  Icons.favorite_border, // Icône contourée
  size: 60, // Taille de l'icône
  color: Colors.red, // Couleur de la bordure
),
                SizedBox(width: 8),
                Text(
                  ' Favorites',
                  style: TextStyle(fontSize: 25, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Grid of Favorites
            Expanded(
              child: favorites.isEmpty
                  ? Center(
                      child: Text(
                        'No favorites yet!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10, 
                        childAspectRatio: 0.8, 
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final placeId = favorites[index];
                        final place = places.firstWhere((p) => p.id == placeId);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(id: place.id),
                              ),
                            );
                          },
                          child: _buildFavoriteCard(
                            title: place.title,
                            imagePath: place.image,
                            price: '\$${place.price.toStringAsFixed(2)}',
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

  // Widget for a favorite card
  Widget _buildFavoriteCard({
    required String title,
    required String imagePath,
    required String price,
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  height: 120, // Adjust height
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Limit text to one line
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              price,
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
