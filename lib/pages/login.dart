import 'package:flutter/material.dart';
import 'firstPage.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Regex for validating email
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Method for signing in
  void signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email and password.')),
      );
      return;
    } else if (!emailRegex.hasMatch(email)) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email format. Please enter a valid email.')),
      );
    } 
    
    else {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstPage()),
    );
    }

}
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
            height: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
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
              SizedBox(height: 150),
              TextField(
                controller: emailController, // Connected to the controller
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController, // Connected to the controller
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signIn,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                  backgroundColor: Color(0xFF7541B0),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
              ),
              SizedBox(height: 20),
              Center(child: Text('OR')),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Add Google login logic here
                  },
                  child: Text(
                    'Google',
                    style: TextStyle(
                      color: Color(0xFF7541B0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
