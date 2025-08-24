import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internshiptask2/week_one/screens/home_screen.dart';

class RoutingScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internship Flutter Tasks",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 15, 153, 239),
              Color.fromARGB(255, 152, 148, 210),
              Color.fromARGB(255, 97, 150, 223),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            _buildTile(
              icon: Icons.api,
              text: "Week 4 - API List",
              onTap: () => Get.off(() => HomeScreen()),
            ),
            _buildTile(
              icon: Icons.login,
              text: "Week 5 - LoginSign up Authentication",
              onTap: () => Get.offNamed('/LoginScreen'),
            ),
            _buildTile(
              icon: Icons.person,
              text: "Week 5 - Profile",
              onTap: () => Get.offNamed('/profile'),
            ),
            _buildTile(
              icon: Icons.task,
              text: "Week 6 - Task List",
              onTap: () => Get.offNamed('/Taskssplash'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String text,
    required Function() onTap,
  }) {
    return Card(
      color: Colors.transparent,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
