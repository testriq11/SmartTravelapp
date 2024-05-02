import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/home/view/home_screen.dart';
import 'package:smarttravelapp/login/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Login')),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigate to ForgotPasswordScreen
                Get.toNamed('/forgot_password');
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement Google login
              },
              child: const Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
