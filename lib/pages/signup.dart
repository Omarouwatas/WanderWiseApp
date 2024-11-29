
import 'package:flutter/material.dart';
import 'login.dart';


class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      body: Center(
        child: Container( // Adjust width to simulate a mobile screen
          padding: const EdgeInsets.all(20.0),
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
          child: SingleChildScrollView( // Makes the content scrollable
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
            
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 20,
                     
                    ),
                  ),
                SizedBox(height: 10),
    
                Text(
                    'WanderWise',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
            
                SizedBox(height: 30),
                // Input Fields
                _buildInputField(label: 'Name', hintText: 'yourname', icon: Icons.person),
                SizedBox(height: 10),
                _buildInputField(label: 'Username', hintText: 'username', icon: Icons.person_outline),
                SizedBox(height: 10),
                _buildInputField(label: 'Phone Number', hintText: '9123456789', icon: Icons.phone),
                SizedBox(height: 10),
                _buildInputField(label: 'Email', hintText: 'yourmail@gmail.com', icon: Icons.email),
                SizedBox(height: 10),
                _buildInputField(
                  label: 'Password',
                  hintText: '********',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                // Buttons
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle sign-up logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xFF7541B0),
                      minimumSize: Size(double.infinity, 50), // Full-width button
                    ),
                    child: Text('Sign Up',style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text('OR'),
                ),
                SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                  // Ajouter la onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginPage()),
                          );
                },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Color(0xFF7541B0),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
