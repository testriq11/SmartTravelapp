import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/booking/view/booking_screen.dart';
import 'package:smarttravelapp/home/view/home_screen.dart';
import 'package:smarttravelapp/login/controller/signup_controller.dart';
import 'package:smarttravelapp/login/view/login_screen.dart';
import 'package:smarttravelapp/login/view/signup_screen.dart';
import 'package:smarttravelapp/splash/welcom_screen.dart';
import 'package:smarttravelapp/login/controller/login_controller.dart'; // Import your LoginController
  import 'package:smarttravelapp/login/view/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
          name: '/signup',
          page: () {
            // Initialize LoginController here
            Get.put(SignUpController());
            return SignUpView();
          },
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(name: '/', page: () => ProfileView(id: Get.arguments['id'])),

        GetPage(name: '/bookingHistory', page: () => BookingHistoryView(id: Get.arguments['id'])),
        // GetPage(
        //   name: '/booking',
        //   page: () => BookingScreen1(destination1: '', destination2: '', destination3: '', responses: []),
        //
        // ),
        // GetPage(
        //   name: '/booking',
        //   page: () {
        //     // Safely get the 'id' argument and provide a default value if it's null
        //     int id = Get.arguments != null && Get.arguments['id'] != null ? Get.arguments['id'] : 0;
        //     return BookingScreen1(id: id);
        //   },
        // ),.
        GetPage(name: '/booking', page: () => BookingScreen1()),
      ],
    );
  }
}
