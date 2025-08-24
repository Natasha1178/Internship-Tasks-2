import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  static Future<User> fetchUser() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users/1"); 
    // replace with your API endpoint

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Example API doesn’t have profilePictureUrl, so we mock it
      return User(
        name: data['name'],
        email: data['email'],
        profilePictureUrl: "https://picsum.photos/200?random=1",
      );
    } else {
      throw Exception("Failed to load user data (Status: ${response.statusCode})");
    }
  }
}