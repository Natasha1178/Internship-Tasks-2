import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internshiptask2/firebase_options.dart';
import 'package:internshiptask2/routing_screens.dart';
import 'package:internshiptask2/week_one/screens/home_screen.dart';
import 'package:internshiptask2/week_one/screens/post_screen.dart';
import 'package:internshiptask2/week_one/screens/user_list_screen.dart';
import 'package:internshiptask2/week_three/views/splash_screen.dart';
import 'package:internshiptask2/week_two/views/login_Screen.dart';
import 'package:provider/provider.dart';
import 'week_one/screens/user_profile_screen.dart';
import 'week_three/controllers/task_provider.dart';
import 'week_three/views/start_screen.dart';
import 'week_three/views/task_list_screen.dart';
import 'week_two/controllers/auth_controller.dart';
import 'week_two/views/profile_screen.dart';
import 'week_two/views/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    Get.put(AuthController()); 
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
         theme: ThemeData(
       primarySwatch: Colors.purple,
       ),
  initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => RoutingScreens()),
        GetPage(name: '/LoginScreen', page: () => LoginScreen()),
        GetPage(name: '/SignupScreen', page: () => SignupScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/Taskssplash', page: () => SplashScreen()),
      ],
);
  }
}
