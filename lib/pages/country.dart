import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart'; // Importez le fichier contenant la page des détails
import 'package:wise2/components/place.dart'; // Importez la classe Place et la liste globale des places

class CountryPage extends StatelessWidget {
  final String selectedCountry;

  CountryPage({required this.selectedCountry});

  @override
  Widget build(BuildContext context) {
    // Filtrer les lieux par pays
    final List<Place> filteredPlaces =
        places.where((place) => place.country == selectedCountry).toList();

    if (filteredPlaces.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedCountry),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Text(
            'No places found for $selectedCountry.',
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 3, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            selectedCountry,
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            labelColor: Color(0xFF7541B0),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF7541B0),
            tabs: [
              Tab(icon: Icon(Icons.hotel), text: 'Hotels'),
              Tab(icon: Icon(Icons.restaurant), text: 'Food'),
              Tab(icon: Icon(Icons.directions_walk), text: 'Adventure'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Hotels Tab
            buildPlacesGrid(filteredPlaces, context),
            // Food Tab
            Center(child: Text('Food options for $selectedCountry')),
            // Adventure Tab
            Center(child: Text('Adventure activities for $selectedCountry')),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire une grille de lieux
  Widget buildPlacesGrid(List<Place> places, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            onTap: () {
              // Naviguer vers la page de détails avec l'objet Place
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(place: place), // Utilise l'objet Place
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      place.image,
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      place.title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${place.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
