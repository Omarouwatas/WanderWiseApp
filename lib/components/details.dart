import 'package:flutter/material.dart';
import 'globals.dart'; // Importez la liste globale des favoris
import 'place.dart'; // Importez la classe Place

class DetailsPage extends StatefulWidget {
  final Place place; // Recevoir un objet de la classe Place

  DetailsPage({required this.place});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Vérifier si l'élément est déjà dans les favoris
    isFavorite = favorites.any((item) => item['title'] == widget.place.title);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        // Supprimer des favoris
        favorites.removeWhere((item) => item['title'] == widget.place.title);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.place.title} a été retiré des favoris.')),
        );
      } else {
        // Ajouter aux favoris
        favorites.add({
          'title': widget.place.title,
          'image': widget.place.image,
          'price': widget.place.price.toString(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.place.title} a été ajouté aux favoris.')),
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
          widget.place.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image principale
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.place.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Titre et prix
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.place.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.place.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Section Facilities
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
                children: widget.place.facilities.map((facility) {
                  return _buildFacilityCard(
                    icon: _getFacilityIcon(facility), // Obtenir l'icône
                    label: facility,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            // Bouton Ajouter aux favoris
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: toggleFavorite,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavorite ? Colors.red : Colors.purple,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour une carte de facility
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

  // Associer une icône aux facilities
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
      default:
        return Icons.help_outline;
    }
  }
}
