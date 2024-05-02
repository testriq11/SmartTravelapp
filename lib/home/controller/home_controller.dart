// import 'package:flutter/material.dart';
// import 'package:smarttravelapp/home/model/ChatModel.dart';
// import 'package:smarttravelapp/home/view/ApiService.dart';
// import '../../booking/view/booking_screen.dart';
//
// class HomeController {
//   final TextEditingController destinationController1 = TextEditingController();
//   final TextEditingController destinationController2 = TextEditingController();
//   final TextEditingController destinationController3 = TextEditingController();
//   final BuildContext context;
//
//   HomeController(this.context);
//
//   Future<void> search() async {
//     String destination1 = destinationController1.text;
//     String destination2 = destinationController2.text;
//     String destination3 = destinationController3.text;
//
//     String prompt =
//         "Make List of Places near by $destination1 to $destination2 to $destination3";
//
//     try {
//       // Make API request using ApiService to get responses
//       List<ChatModel> responses = await ApiService.sendMessage(
//         message: prompt,
//         modelId: 'gpt-3.5-turbo-0301',
//       );
//
//       // Extract messages from responses
//       List<String> messages = responses.map((e) => e.msg).toList();
//
//       // Navigate to booking screen with responses
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BookingScreen1(
//             destination1: destination1,
//             destination2: destination2,
//             destination3: destination3,
//             responses: messages,
//           ),
//         ),
//       );
//     } catch (e) {
//       // Error handling
//       print("Error: $e");
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(e.toString()),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/home/model/ChatModel.dart';
import 'package:smarttravelapp/home/view/ApiService.dart';
import '../../booking/view/booking_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

//
// class HomeController extends GetxController {
//   final TextEditingController destinationController1 = TextEditingController();
//   final TextEditingController destinationController2 = TextEditingController();
//   final TextEditingController destinationController3 = TextEditingController();
//   RxString selectedRoute = 'car'.obs;
//
//   Future<void> search(String selectedRoute) async {
//     String destination1 = destinationController1.text;
//     String destination2 = destinationController2.text;
//     String destination3 = destinationController3.text;
//     // String selectedRoute = controller.selectedRoute.value;
//
//     // Get current location of the user
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     String latitude = position.latitude.toString();
//     String longitude = position.longitude.toString();
//     String? placeName = await _getPlaceName(position);
//
//     String prompt =
//         "my current location is $placeName & the GPS coordinates are (Latitude: $latitude, Longitude: $longitude) I am planning to visit  $destination1 & $destination2 & $destination3 by road using $selectedRoute, show me the nearby places to visit and a road map with a suitable route, show me the detailed plan";
// print("prompt$prompt");
//     // "my current location is $placeName & the GPS coordinates are (Latitude: $latitude, Longitude: $longitude) I am planning to visit by raod $destination1 & $destination2 & $destination3 show me the nearby places to visit and a road map with a suitable route for car,show me the detailed plan";
//     // my current location is Mira Road & the GPS coordinates are 19.293446, 72.871010, I am planning to visit Nashik by road, show me the nearby places to visit, and a road map with a suitable route for car, show me the detailed plan.
//     try {
//       // Make API request using ApiService to get responses
//       List<ChatModel> responses = await ApiService.sendMessage(
//         message: prompt,
//         modelId: 'gpt-3.5-turbo-0301',
//       );
//
//       // Extract messages from responses
//       List<String> messages = responses.map((e) => e.msg).toList();
//   print("Mes>>$messages");
//       // Navigate to booking screen with responses
//       Get.toNamed(
//         '/booking',
//         arguments: {
//           'destination1': destination1,
//           'destination2': destination2,
//           'destination3': destination3,
//           'responses': messages,
//         },
//       );
//
//
//     } catch (e) {
//       // Error handling
//       print("Error: $e");
//       Get.dialog(
//         AlertDialog(
//           title: Text("Error"),
//           content: Text(e.toString()),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   // Function to get place name from coordinates
// // Function to get place name from coordinates
// // Function to get place name from coordinates
//   Future<String?> _getPlaceName(Position position) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude, position.longitude);
//     return placemarks.isNotEmpty ? placemarks[0].name : 'Unknown Place';
//   }
//
//
//
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class HomeController extends GetxController {
  final TextEditingController destinationController1 = TextEditingController();
  final TextEditingController destinationController2 = TextEditingController();
  final TextEditingController destinationController3 = TextEditingController();
  RxString selectedRoute = 'car'.obs;

  // Create a new instance of http.Client
  final client = http.Client();

  // Set the timeout duration (in milliseconds)
  final timeoutDuration = Duration(seconds: 40);

  Future<void> search(String selectedRoute) async {
    String destination1 = destinationController1.text;
    String destination2 = destinationController2.text;

    // Get current location of the user
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    String? placeName = await _getPlaceName(position);

    String prompt =
        "my current location is $placeName & the GPS coordinates are (Latitude: $latitude, Longitude: $longitude) I am planning to visit from  $placeName to $destination2  by road using $selectedRoute, show me the nearby places to visit";

    try {
      // Make API request using ApiService to get responses
      List<ChatModel> responses = await ApiService.sendMessage(
        message: prompt,
        modelId: 'gpt-3.5-turbo-0301',
      );

      // Extract messages from responses
      List<String> messages = responses.map((e) => e.msg).toList();
      print("Mes>>$messages");

      // Navigate to booking screen with responses and prompt
      Get.toNamed(
        '/booking',
        arguments: {
          'destination1': destination1,
          'destination2': destination2,
          'responses': messages,
          'prompt': prompt, // Pass prompt here
        },
      );
    } catch (e) {
      // Error handling
      print("Error: $e");
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<String?> _getPlaceName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    return placemarks.isNotEmpty ? placemarks[0].name : 'Unknown Place';
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 20), // Set a timeout of 5 seconds
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      String currentLocation =
      placemarks.isNotEmpty ? placemarks[0].name ?? 'Unknown Place' : 'Unknown Place';
      destinationController1.text = currentLocation;
    } on TimeoutException catch (e) {
      print('Error getting current location: $e');
      // Show a dialog to inform the user about the error
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(
              "Couldn't get your current location within the specified time. Please make sure your GPS is enabled and try again."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } on PlatformException catch (e) {
      print('Error getting current location: $e');
      // Show a dialog to inform the user about the error
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(
              "Couldn't get your current location. Please make sure your GPS is enabled and try again."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error getting current location: $e');
      // Show a dialog to inform the user about the error
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(
              "Couldn't get your current location. Please make sure your GPS is enabled and try again."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}

