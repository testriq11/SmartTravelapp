import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/booking/view/booking_screen.dart';
import 'package:smarttravelapp/home/view/home_screen.dart';
import 'package:smarttravelapp/login/view/login_screen.dart';
import 'package:smarttravelapp/splash/welcom_screen.dart';
import 'package:smarttravelapp/login/controller/login_controller.dart'; // Import your LoginController

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // other configurations...
      getPages: [
        GetPage(
          name: '/',
          page: () => WelcomeScreen(),
        ),
        GetPage(
          name: '/login',
          page: () {
            // Initialize LoginController here
            Get.put(LoginController());
            return LoginScreen();
          },
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        // GetPage(
        //   name: '/booking',
        //   page: () => BookingScreen1(destination1: '', destination2: '', destination3: '', responses: []),
        //
        // ),
        GetPage(name: '/booking', page: () => BookingScreen1()),
      ],
    );
  }
}
