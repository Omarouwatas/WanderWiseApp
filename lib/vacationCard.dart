import 'package:flutter/material.dart';
import 'package:wise2/pages/login.dart';
import 'package:wise2/pages/login.dart';
class VacationCard extends StatelessWidget {
  const VacationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('images/Rectangle988.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // Text and button
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      
                      children: const [
                        Text(
                          '   Wander',
                          style: TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'PinyonScript',
                            height: 0.6,
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '     WISE',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              height: 0.5,
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          ' Plan your',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            height: 1.1,
                          ),
                        ),
                        Text(
                            'Luxurious             Vacation',
                            style: TextStyle( 
                              fontSize: 55,
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              height: 1,
                            ),
                          ),
                
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7541B0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(430, 60),
                        ),
                        child: const Text(
                          'Explore',
                          style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'OpenSans'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
