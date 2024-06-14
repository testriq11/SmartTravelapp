import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../constants/api_consts.dart'; // Import dart:convert to use json.encode

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpController extends GetxController {
  var isLoading = false.obs;

  Future<bool> signUp(String username, String email, String password) async {
    isLoading.value = true;

    try {
      final url = '$NGROK_URL/signup/signup';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User registered successfully',
            snackPosition: SnackPosition.BOTTOM);
        return true; // Return true indicating successful registration
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Get.snackbar('Error', 'Failed to register user: ${responseData['error']}',
            snackPosition: SnackPosition.BOTTOM);
        return false; // Return false indicating failed registration
      }
    } catch (e) {
      isLoading.value = false;
      print('Exception occurred during sign up: $e');
      Get.snackbar('Error', 'An error occurred during sign up',
          snackPosition: SnackPosition.BOTTOM);
      return false; // Return false in case of exception
    }
  }

}


