import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'package:dio/dio.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Regex for validating email
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  // Function to register the user
 

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3), 
    headers: {'Content-Type': 'application/json'},
  ),
);


Future<void> registerUser() async {
  final name = nameController.text;
  final lastName = lastNameController.text;
  final username = usernameController.text;
  final email = emailController.text;
  final password = passwordController.text;

  if (name.isEmpty || lastName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All fields are required.')),
    );
    return;
  }

  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid email format. Please enter a valid email.')),
    );
    return;
  }

  final body = {
    'first_name': name,
    'last_name': lastName,
    'username': username,
    'email': email,
    'password': password,
  };

  try {
    final response = await dio.post('register/', data: body);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Handle backend validation errors
      final error = response.data['error'] ?? 'Registration failed.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  } on DioError catch (e) {
    // Handle Dio-specific errors
    if (e.response != null) {
      // Server responded with an error
      print('Error Response: ${e.response?.data}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response?.data['error'] ?? 'An error occurred.')),
      );
    } else {
     
      print('Dio Error: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: ${e.message}')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: Center(
        child: Container(
          height: double.infinity,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'WanderWise',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 70),
                _buildInputField(
                  label: 'FirstName',
                  hintText: 'Firstname',
                  icon: Icons.person,
                  controller: nameController,
                ),
                SizedBox(height: 10),
                _buildInputField(
                  label: 'LastName',
                  hintText: 'Last name',
                  icon: Icons.person,
                  controller: lastNameController,
                ),
                SizedBox(height: 10),
                _buildInputField(
                  label: 'Username',
                  hintText: 'username',
                  icon: Icons.person_outline,
                  controller: usernameController,
                ),
                SizedBox(height: 10),
                _buildInputField(
                  label: 'Email',
                  hintText: 'yourmail@gmail.com',
                  icon: Icons.email,
                  controller: emailController,
                ),
                SizedBox(height: 10),
                _buildInputField(
                  label: 'Password',
                  hintText: '',
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: registerUser, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color(0xFF7541B0),
                      minimumSize: Size(double.infinity, 50), 
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Color(0xFF7541B0),
                      ),
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
  required TextEditingController controller,
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
        controller: controller, // Bind the controller here
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
