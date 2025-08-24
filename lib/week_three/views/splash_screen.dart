import "dart:async";

import "package:flutter/material.dart";
import "package:internshiptask2/week_three/views/start_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 243, 239, 58),
              const Color.fromARGB(255, 234, 231, 208),
              const Color.fromARGB(255, 243, 239, 58),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(30),
                        child: Center(child: Image.asset("assets/logo.jpg" ,height: 60,width: 60,fit: BoxFit.cover,),),),
                        SizedBox(width: 15,),
                      const Text(
                        'Taski',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 131, 54, 5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),                        
                    ],
                                                    
                  ),
                   SizedBox(height: 50),
                   CircularProgressIndicator(color: Colors.white),
                ],
                
              ),
            ),
    
    );
  }
}
