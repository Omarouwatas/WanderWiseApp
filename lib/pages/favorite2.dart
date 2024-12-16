import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart';
import 'package:wise2/components/place.dart';
import 'package:wise2/components/globals.dart';

class Favorites2 extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: const Color.fromARGB(255, 231, 163, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'WanderWise',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 50),
                SizedBox(width: 8),
                Text(
                  'Your Favorites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Listen to Favorites Changes
            Expanded(
              child: ValueListenableBuilder<List<String>>(
                valueListenable: favorites,
                builder: (context, currentFavorites, _) {
                  final favoritePlaces = localPlaces
                      .where((place) => currentFavorites.contains(place.id))
                      .toList();

                  return favoritePlaces.isEmpty
                      ? Center(
                          child: Text(
                            'No favorites yet!',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: favoritePlaces.length,
                          itemBuilder: (context, index) {
                            final place = favoritePlaces[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(id: place.id),
                                  ),
                                );
                              },
                              child: _buildFavoriteCard(
                                title: place.title,
                                imagePath: place.image,
                                price: place.city,
                                onToggleFavorite: () =>
                                    _toggleFavorite(place.id),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Toggle favorite
  void _toggleFavorite(String id) {
    if (favorites.value.contains(id)) {
      favorites.value = List.from(favorites.value)..remove(id);
    } else {
      favorites.value = List.from(favorites.value)..add(id);
    }
  }

  // Favorite card widget
  Widget _buildFavoriteCard({
    required String title,
    required String imagePath,
    required String price,
    required VoidCallback onToggleFavorite,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth * 1.2;

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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
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
                            child: Icon(Icons.error,
                                color: Colors.red, size: 40),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onToggleFavorite,
                      child: Icon(
                        favorites.value.contains(title)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favorites.value.contains(title)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
