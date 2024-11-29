class Place {
  final String id;
  final String title;
  final double price;
  final String country;
  final String description;
  final List<String> facilities;
  final String image;

  Place({
    required this.id,
    required this.title,
    required this.price,
    required this.country,
    required this.description,
    required this.facilities,
    required this.image,
  });
}
final List<Place> places = [
  Place(
    id: '1',
    title: 'Coeurdes Alpes',
    price: 6299.0,
    country: 'France',
    description: 'A beautiful alpine resort in the heart of France.',
    facilities: ['WiFi', 'Pool', 'Spa'],
    image: 'images/fav1.jpg',
  ),
  Place(
    id: '2',
    title: 'Beach Stone',
    price: 6299.0,
    country: 'France',
    description: 'A serene beach getaway with stunning views.',
    facilities: ['WiFi', 'Beach Access', 'Bar'],
    image: 'images/fav2.jpg',
  ),
  Place(
    id: '3',
    title: 'Isle Of Pines',
    price: 6299.0,
    country: 'Italy',
    description: 'A beautiful island with breathtaking scenery.',
    facilities: ['WiFi', 'Luxury Rooms', 'Private Tours'],
    image: 'images/fav3.jpg',
  ),
  Place(
    id: '4',
    title: 'Beach Maldives',
    price: 6299.0,
    country: 'Italy',
    description: 'Experience paradise with crystal clear waters.',
    facilities: ['WiFi', 'Ocean View', 'Infinity Pool'],
    image: 'images/fav4.jpg',
  ),
];
