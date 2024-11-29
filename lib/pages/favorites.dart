import 'package:flutter/material.dart';
import 'package:wise2/components/globals.dart'; // Importez la liste globale des favoris

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Fond bleu clair
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WanderWise',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  'Favorites',
                  style: TextStyle(fontSize: 28,fontFamily: "OpenSans"),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Favorites Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red,size: 50,),
                    SizedBox(width: 8),
                    Text(
                      'There you go ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                        crossAxisCount: 2, // Deux colonnes
                        mainAxisSpacing: 10, // Espacement vertical
                        crossAxisSpacing: 10, // Espacement horizontal
                        childAspectRatio: 0.9, // Proportion des cartes
                      ),
                      itemCount: favorites.length, // Nombre d'éléments dynamiques
                      itemBuilder: (context, index) {
                        final favorite = favorites[index];
                        final title = favorite["title"] ?? "Unknown Title"; // Utiliser un titre par défaut
                        final imagePath = favorite["imagePath"] ?? "images/aspen3.jpg"; // Utiliser une image par défaut
                        final price = favorite["price"] ?? "000";
                        return _buildFavoriteCard(
                            title: title,
                            imagePath: imagePath,
                            price :price,
                            );
                        },

                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour la carte d'un favori
  Widget _buildFavoriteCard({required String title, required String imagePath ,required String price}) {
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
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              price,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
