import 'package:flutter/material.dart';
import 'package:wise2/pages/editProfile.dart';
import 'package:wise2/pages/help.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
                ),
                Text(
                  'WanderWise',
                  style: TextStyle(fontSize: 28, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Carte de profil
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Image de profil
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/Jacob.jpg'), // Chemin de votre image
                    ),
                    SizedBox(height: 10),
                    // Nom et description
                    Text(
                      'Jacob Jones',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
            
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Liste des options
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> ProfileEdit()), );
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.lock,
                    title: 'Privacy & Security',
                    onTap: () {},
                  ),
                 _buildProfileOption(
                icon: Icons.help_outline,
                 title: 'Help',
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage()),
    );
  },
),

                ],
              ),
            ),
            // Bouton en bas
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logique pour "Edit personal information"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Edit personal information',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour une option de profil
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
