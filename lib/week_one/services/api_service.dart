import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users/1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }
}