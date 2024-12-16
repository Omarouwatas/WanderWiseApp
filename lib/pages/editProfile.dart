import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color to match the main interface
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Back button color
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black, // Title color
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your profile information',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Name',
              hintText: 'Enter your name',
              icon: Icons.person,
            ),
            SizedBox(height: 20),
            // Password Field
            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              hintText: 'Enter your password',
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 20),
            // Confirm Password Field
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hintText: 'Re-enter your password',
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 40),
            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate if passwords match
                  if (_passwordController.text == _confirmPasswordController.text) {
                    print('Name: ${_nameController.text}');
                    print('Password: ${_passwordController.text}');
                    // Add logic to save the updated information
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7541B0), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 155, vertical: 15),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Field Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Color(0xFF7541B0)), // Icon color
        filled: true,
        fillColor: Colors.grey[100], // Light grey background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
