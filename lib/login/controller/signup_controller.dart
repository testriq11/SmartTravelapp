import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../constants/api_consts.dart'; // Import dart:convert to use json.encode

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpController extends GetxController {
  var isLoading = false.obs;

  Future<void> signUp(String username, String email, String password) async {
    isLoading.value = true;
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
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      Get.snackbar('Error', 'Failed to register user: ${responseData['error']}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}


