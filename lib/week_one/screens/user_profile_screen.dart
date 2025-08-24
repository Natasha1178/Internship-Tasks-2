import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internshiptask2/week_one/screens/home_screen.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserService.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,letterSpacing: 1.0),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.to(HomeScreen());
          },
          child: Icon(Icons.arrow_back_ios, size: 20)),
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Loading spinner
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            ); // Error handling
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      foregroundColor: Colors.blueGrey,
                      backgroundImage: user.profilePictureUrl != null
                          ? NetworkImage(user.profilePictureUrl!)
                          : null,
                      child: user.profilePictureUrl == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    Divider(),
                    SizedBox(height: 10),
                    Column(
                      children: [
                         buildOptionRow(Icons.punch_clock_sharp, "order History"),
                        buildOptionRow(
                          Icons.location_city_outlined,
                          "Shipping Address",
                        ),
                         buildOptionRow(Icons.request_page_outlined, "Create Request"),
                         buildOptionRow(Icons.policy, "private Policy"),
                        buildOptionRow(Icons.settings, "Setting"),
                        buildOptionRow(Icons.logout, "Log out"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    BottomNavigationBar(
                      backgroundColor: Color.fromARGB(255, 193, 214, 231),

        selectedItemColor: Colors.orange, // Active color
        unselectedItemColor: Colors.grey, // Inactive color
        showUnselectedLabels: true, // Show text for all
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
                  ],
                  
                ),
              ),
            );
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}

Widget buildOptionRow(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: Row(
      children: [
        // Left circular icon
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 145, 92),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),

        // Expanded text (will align all rows properly)
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
          ),
        ),

        // Right arrow
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 230, 145, 92),
          size: 16,
        ),
      ],
    ),
  );
}
