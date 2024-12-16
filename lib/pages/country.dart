import 'package:flutter/material.dart';
import 'package:wise2/components/details.dart'; 
import 'package:wise2/components/place.dart'; 

class CountryPage extends StatefulWidget {
  final String selectedCity;

  CountryPage({required this.selectedCity});

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late Future<List<Place>> _places;

  @override
  void initState() {
    super.initState();
    _places = fetchPlaces(widget.selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: _places,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.selectedCity),
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.selectedCity),
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: Text(
                'No places found for ${widget.selectedCity}.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          );
        } else {
          // Filter categories dynamically
          final List<Place> filteredPlaces = snapshot.data!;
          final List<Place> Hotels = filteredPlaces.where((place) => place.category == "Hotel").toList();
          final List<Place> restaurant = filteredPlaces.where((place) => place.category == "Restaurant").toList();
          final List<Place> Adventure = filteredPlaces.where((place) => place.category == "Adventure").toList();

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  widget.selectedCity,
                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                bottom: const TabBar(
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
                  buildPlacesGrid(Hotels, context),
                  buildPlacesGrid(restaurant, context),
                  buildPlacesGrid(Adventure, context),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

Widget buildPlacesGrid(List<Place> places, BuildContext context) {
  if (places.isEmpty) {
    return Center(
      child: Text(
        "No options for this category",
        style: TextStyle(fontSize: 16, fontFamily: "OpenSans", color: Colors.grey),
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 4, 
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(id: place.id),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), 
              child: Stack(
                children: [
                  Image.network(
                    place.image,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Title Box
                  Positioned(
                    bottom: 45,
                    left: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 121, 120, 120).withOpacity(0.8), 
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        place.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Ratings Box
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7), // Light gray background
                        borderRadius: BorderRadius.circular(20), // Larger border radius
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            place.ratings.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
