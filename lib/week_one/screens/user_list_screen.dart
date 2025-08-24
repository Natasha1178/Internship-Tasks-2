import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = fetchUsers();
  }

  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/?results=10'), // ask for 10 users
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results']; // ✅ Extract the list of users
      } else {
        throw Exception("Failed to load users. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Users',style: TextStyle(color: Colors.white),), centerTitle: true,
         leading: InkWell(
          onTap: (){
            Get.to(HomeScreen());
          },
          child: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,)),
        ),
      body: FutureBuilder<List<dynamic>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        "https://picsum.photos/seed/user$index/200",
                      ),
                      onBackgroundImageError: (_, __) {},
                      child: ClipOval(
                        child: Image.network(
                          "https://picsum.photos/seed/user$index/200",
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      "${user['name']['first']} ${user['name']['last']}",
                    ),
                    subtitle: Text(user['email']),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
