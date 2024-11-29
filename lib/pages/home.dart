import 'package:flutter/material.dart';
import 'country.dart'; // Import de la nouvelle page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> countries = ['France', 'Spain', 'Canada', 'Brazil', 'Germany', 'Italy', 'Japan'];

  bool _showImage = false; // Contrôle pour afficher ou masquer l'image
  String? _selectedCountry; // Le pays sélectionné

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Nombre d'onglets
      child: Scaffold(
        backgroundColor: Colors.blue[50], // Fond bleu clair
        body: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Ajout d'un léger border radius à toute la page
          child: Container(
            width: double.infinity, // Occupe toute la largeur
            height: double.infinity, // Occupe toute la hauteur
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // Coins arrondis pour la page
            ),
            child: SingleChildScrollView( // Permet le défilement si nécessaire
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre "Home" et "WanderWise"
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Text(
                        'WanderWise',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Barre de recherche avec largeur ajustée
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // Plus large
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF7541B0),
                        hintText: 'Find your destination',
                        hintStyle: TextStyle(
                          color: Colors.white, // Couleur du texte indicatif (hint text)
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none, // Pas de bordure visible
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, // Contrôle direct de la hauteur interne
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // Dropdown pour sélectionner un pays avec largeur plus petite et un border radius
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6, // Plus petite que "Find your destination"
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 67, 148, 246), // Couleur du fond
                        borderRadius: BorderRadius.circular(30), // Bordure arrondie
                        border: Border.all(
                          color: Colors.white, // Couleur du border
                          width: 1.5, // Épaisseur
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true, // Permet au DropdownButton de prendre toute la largeur
                          dropdownColor: Color.fromARGB(255, 67, 148, 246), // Couleur de fond de la liste déroulante
                          icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Flèche stylisée
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _selectedCountry ?? 'Country', // Affiche le pays sélectionné ou le hint
                              style: TextStyle(
                                color: Colors.white, // Couleur du texte indicatif
                                fontSize: 16, // Taille de la police
                              ),
                            ),
                          ),
                          items: countries
                              .map((country) => DropdownMenuItem<String>(
                                    value: country,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Text(
                                        country,
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Logique de sélection du pays
                            setState(() {
                              _selectedCountry = value; // Remplace le texte du champ par le pays sélectionné
                              _showImage = true; // Afficher l'image après sélection
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Image animée
                  AnimatedOpacity(
                    duration: Duration(seconds: 1), // Durée de l'animation
                    opacity: _showImage ? 1.0 : 1.0, // Contrôle de l'opacité
                    child: Center(
                      child: Image.asset(
                        'images/Earth.png', // Remplacez par votre chemin d'image
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Bouton "Explore it"
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedCountry != null) {
                          // Naviguer vers la page CountryPage avec le pays sélectionné
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountryPage(selectedCountry: _selectedCountry!),
                            ),
                          );
                        } else {
                          // Afficher un message si aucun pays n'est sélectionné
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a country first!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7541B0),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Explore it',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
