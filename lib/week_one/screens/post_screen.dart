import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
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
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
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
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Card(
                    shape: Border.all(color: Colors.black),                    
                    color: const Color.fromARGB(255, 241, 217, 183),
                    elevation: 6,
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                                
                    title: Text(posts[index].title,style: TextStyle(
                        color: const Color.fromARGB(255, 6, 7, 11),
                        fontWeight: FontWeight.bold),),
                        subtitle: Text(posts[index].body,style: TextStyle(
                        color: const Color.fromARGB(255, 96, 99, 100)
                      ),),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}