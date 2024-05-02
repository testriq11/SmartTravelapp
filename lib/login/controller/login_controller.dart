import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  void login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // Implement your login logic here
      isLoading.value = true; // Set loading to true during login process
      // Simulating login process with a delay
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false; // Set loading to false after login process
        // Navigate to HomeScreen
        Get.offAllNamed('/home');
      });
    } else {
      Get.snackbar('Error', 'Please enter email and password',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//
//   void login() async {
//     String email = emailController.text;
//     String password = passwordController.text;
//
//     if (email.isNotEmpty && password.isNotEmpty) {
//       isLoading.value = true;
//
//       try {
//         var url = Uri.parse('https://be73-202-179-91-72.ngrok-free.app/login');
//
//         // Encode the data as JSON
//         var body = json.encode({'email': email, 'password': password});
//
//         var response = await http.post(
//           url,
//           headers: {
//             'Content-Type': 'application/json', // Set the content type to JSON
//           },
//           body: body,
//         );
//
//         if (response.statusCode == 200) {
//           // Success
//           isLoading.value = false;
//           // Navigate to HomeScreen
//           Get.offAllNamed('/home');
//         } else {
//           // Error
//           isLoading.value = false;
//           Get.snackbar('Error', 'Failed to register user');
//         }
//       } catch (e) {
//         print('Error: $e');
//         isLoading.value = false;
//         Get.snackbar('Error', 'Failed to connect to server');
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter email and password',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
