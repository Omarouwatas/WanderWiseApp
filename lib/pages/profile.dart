import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wise2/components/fetchProfile.dart';
import 'package:wise2/pages/editProfile.dart';
import 'package:wise2/pages/help.dart';
import 'package:wise2/vacationCard.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = fetchUserProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load profile'));
            } else {
              final profile = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      color: Colors.black, 
                    ),
                  ),
             
                  Text(
                    'WanderWise',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'OpenSans',
                      color: Colors.black, 
                    ),
                  ),
                  SizedBox(height: 20),
          
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/profile.webp'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            profile['username'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Liste des options du profil
                  Expanded(
                    child: ListView(
                      children: [
                        _buildProfileOption(
                          icon: Icons.person,
                          title: 'Profile',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage() ));
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
                              MaterialPageRoute(
                                builder: (context) => HelpPage(),
                              ),
                            );
                          },
                        ),
                        _buildProfileOption(
                          icon: Icons.logout,
                          title: 'Logout',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VacationCard(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF7541B0)), // Couleur personnalisée pour les icônes
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Texte noir pour cohérence
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
