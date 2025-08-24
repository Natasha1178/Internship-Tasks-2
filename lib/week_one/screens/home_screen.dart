import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:internshiptask2/routing_screens.dart";
import "package:internshiptask2/week_one/screens/user_list_screen.dart";

import "post_screen.dart";
import "user_profile_screen.dart";
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Integration',
      style: TextStyle(color:Colors.indigo)),centerTitle: true,
      leading: IconButton(onPressed: (){
        Get.offNamed('/RoutingScreens');
      }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             containerClick("Post Screen", onTap: () {
          
              Get.to(PostsScreen());
              }),
              SizedBox(height: 20),
              containerClick("Users List ", onTap: () {
                 Get.to(UserListScreen());
                
          
              }),
               SizedBox(height: 20),
              containerClick("User Profile  ", onTap: () {
               Get.to(UserProfileScreen());
              }),
              ],
          ),
        )
        ),
      
    
    );
  }
}
Widget containerClick(String title, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap, // makes it clickable
    child: Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color.fromARGB(255, 202, 213, 76),
          width: 2.0,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}