import 'package:flutter/material.dart';
import 'country.dart'; 
import 'package:wise2/components/globals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String? _selectedCountry; // Le pays sélectionné
  String? _selectedCity; // La ville sélectionnée
  String _mapImage = 'images/Earth.png'; // Image par défaut

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Nombre d'onglets
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              
            ),
            child: SingleChildScrollView(
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
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        ),),
                      Text(
                        'WanderWise',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  // DropdownButton pour sélectionner un pays
                 // DropdownButton pour sélectionner un pays
SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  child: DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent, // Fond transparent
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Coins arrondis
        borderSide: BorderSide(color: Colors.grey), // Bordure grise
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey), // Bordure pour état normal
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blue, width: 2), // Bordure pour état sélectionné
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
    ),
    icon: Icon(
      Icons.arrow_drop_down, // Icône de menu déroulant
      color: Colors.grey, // Couleur de l'icône
    ),
    hint: Text(
      'Find your destination',
      style: TextStyle(
        color: Colors.black, // Texte clair
        fontSize: 16,
        fontFamily: "OpenSans",
      ),
    ),
    dropdownColor: Colors.white.withOpacity(0.9), // Fond légèrement transparent pour le menu
    items: countriesAndCities.keys.map((country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(
          country,
          style: TextStyle(
            color: const Color.fromARGB(255, 117, 65, 176), // Couleur du texte des options
            fontSize: 14,
          ),
        ),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        _selectedCountry = value;
        _selectedCity = null;
        _mapImage = 'images/country/${value!.toLowerCase()}.png'; // Change l'image
      });
    },
  ),
),

                  SizedBox(height: 20),

                  // DropdownButton pour sélectionner une ville
if (_selectedCountry != null)
  SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: DropdownButtonFormField<String>(
      value: _selectedCity,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF7541B0), // Couleur de fond mauve
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Coins arrondis
          borderSide: BorderSide.none, // Pas de bordure
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
      icon: Icon(
        Icons.search,
        color: Colors.white, // Icône blanche
      ),
      hint: Text(
        'Select a city', // Texte du titre
        style: TextStyle(
          color: Color.fromARGB(255, 247, 246, 248), // Couleur violette
          fontSize: 16,
          fontFamily: "OpenSans",
        ),
      ),
      dropdownColor: Color(0xFF7541B0), // Fond mauve pour le menu déroulant
      items: countriesAndCities[_selectedCountry]!
          .map((city) => DropdownMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: TextStyle(
                    color: Colors.white, // Texte blanc pour les options
                    fontFamily: 'OpenSans',
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCity = value;
        });
      },
    ),
  ),

                  SizedBox(height: 20),

                  
                  Center(
  child: AnimatedOpacity(
    duration: Duration(seconds: 1),
    opacity: 1.0,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Border radius for the container
      
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Match the border radius
        child: Image.asset(
          _mapImage, // Image path
          height: 300,
          width: MediaQuery.of(context).size.width * 1.2,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
),

                  
                  SizedBox(height: 35),

                
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedCountry != null && _selectedCity != null) {
                      
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountryPage(
                                selectedCity: _selectedCity!,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select both a country and a city!'),
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
                          fontFamily: "OpenSans"
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
