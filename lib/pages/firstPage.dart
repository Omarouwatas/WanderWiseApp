
import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'favorites.dart';
import 'recommandation.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState(); // Fixed incorrect usage.
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  // Function to navigate between pages
  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of pages for the navigation
  final List<Widget> _pages = [
    HomePage(),
    RecommendationsPage(),
    Favorites(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
              body: _pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _navigate,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFF7541B0),
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore),
                    label: 'Recommendation',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          }
}
