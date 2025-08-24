import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final isLoading = false.obs;

  // SIGN UP: create auth user + store name/email in Firestore
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Account created. Please log in.',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed('/LoginScreen');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Signup failed',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // LOGIN: go to profile
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Success', 'Logged in successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
print('Login successful, navigating to profile...');
      Get.offAllNamed('/profile');
      
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/LoginScreen');
  }

  // Stream user doc for real-time updates on Profile screen
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDocStream() {
    final uid = _auth.currentUser?.uid;
    return _firestore.collection('users').doc(uid).snapshots();
  }
}
