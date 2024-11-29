import 'package:flutter/material.dart';
import 'firstPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Déclaration des contrôleurs pour les champs de texte
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Méthode de connexion
  void SignIn() {
    final email = emailController.text;
    final password = passwordController.text;

    // Exemple de logique de connexion
    if (email.isNotEmpty && password.isNotEmpty) {
      // Naviguer vers la Home Page après connexion réussie
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
      );
    } else {
      // Afficher un message si les champs sont vides
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email and password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 150),
              TextField(
                controller: emailController, // Connecté au contrôleur
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController, // Connecté au contrôleur
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: SignIn,
                style: ElevatedButton.styleFrom(
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
                  
                },
                style: OutlinedButton.styleFrom(
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
                    // Ajouter la logique de connexion Google ici
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
