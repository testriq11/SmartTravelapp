  // import 'package:flutter/material.dart';
  // import 'package:smarttravelapp/home/model/ChatModel.dart';
  // import 'package:smarttravelapp/home/model/ModelsModel.dart';
  // import 'package:smarttravelapp/home/view/ApiService.dart';
  // import '../../booking/view/booking_screen.dart';
  //
  // class HomeScreen extends StatefulWidget {
  //   const HomeScreen({Key? key}) : super(key: key);
  //
  //   @override
  //   _HomeScreenState createState() => _HomeScreenState();
  // }
  //
  // class _HomeScreenState extends State<HomeScreen> {
  //   TextEditingController destinationController1 = TextEditingController();
  //   TextEditingController destinationController2 = TextEditingController();
  //   TextEditingController destinationController3 = TextEditingController();
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Home'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextField(
  //               controller: destinationController1,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 1',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: destinationController2,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 2',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: destinationController3,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 3',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () async {
  //                 String destination1 = destinationController1.text;
  //                 String destination2 = destinationController2.text;
  //                 String destination3 = destinationController3.text;
  //
  //                 String prompt =
  //                     "Make List of Places near by $destination1 to $destination2 to $destination3";
  //
  //                 try {
  //                   // Make API request using ApiService to get responses
  //                   List<ChatModel> responses = await ApiService.sendMessage(
  //                     message: prompt,
  //                     modelId: 'gpt-3.5-turbo-0301',
  //                   );
  //
  //                   // Extract messages from responses
  //                   List<String> messages =
  //                   responses.map((e) => e.msg).toList();
  //
  //                   // Navigate to booking screen with responses
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => BookingScreen1(
  //                         destination1: destination1,
  //                         destination2: destination2,
  //                         destination3: destination3,
  //                         responses: messages,
  //                       ),
  //                     ),
  //                   );
  //                 } catch (e) {
  //                   // Error handling
  //                   print("Error: $e");
  //                   showDialog(
  //                     context: context,
  //                     builder: (context) {
  //                       return AlertDialog(
  //                         title: Text("Error"),
  //                         content: Text(e.toString()),
  //                         actions: [
  //                           TextButton(
  //                             onPressed: () {
  //                               Navigator.of(context).pop();
  //                             },
  //                             child: Text("OK"),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   );
  //                 }
  //               },
  //               child: Text('Search'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


  // import 'package:flutter/material.dart';
  // import 'package:smarttravelapp/home/controller/home_controller.dart';
  //
  // class HomeScreen extends StatelessWidget {
  //   final HomeController controller;
  //
  //   const HomeScreen({Key? key, required this.controller}) : super(key: key);
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Home'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextField(
  //               controller: controller.destinationController1,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 1',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: controller.destinationController2,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 2',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: controller.destinationController3,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 3',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: controller.search,
  //               child: Text('Search'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:smarttravelapp/home/controller/home_controller.dart';
  //
  // class HomeScreen extends StatelessWidget {
  //   final HomeController controller = Get.put(HomeController());
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Home'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextField(
  //               controller: controller.destinationController1,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 1',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: controller.destinationController2,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 2',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             TextField(
  //               controller: controller.destinationController3,
  //               decoration: InputDecoration(
  //                 labelText: 'Search Destination 3',
  //                 suffixIcon: Icon(Icons.add),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: controller.search,
  //               child: Text('Search'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:smarttravelapp/home/controller/home_controller.dart';

  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:smarttravelapp/home/controller/home_controller.dart';

  class HomeScreen extends StatelessWidget {
    final HomeController controller = Get.put(HomeController());

    @override
    Widget build(BuildContext context) {
      final arguments = Get.arguments;
      final String username = arguments['username'];
      final int id = arguments['id'];
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Display the username and id
                  Text('Welcome, $username!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Your ID is $id', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),

                  _buildDestinationTextField(controller.destinationController1, 'Current Location', Icons.my_location, () async {
                    await controller.getCurrentLocation();
                  }),
                  _buildDestinationTextField(controller.destinationController2, 'Search Destination 2', Icons.location_on, null),
                  SizedBox(height: 20),
                  Text('Preferred Route:', style: TextStyle(fontSize: 16)),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'car',
                        groupValue: controller.selectedRoute.value,
                        onChanged: (value) {
                          controller.selectedRoute.value = value.toString();
                        },
                      ),
                      Row(
                        children: [
                          Icon(Icons.directions_car),
                        ],
                      ),
                      Radio(
                        value: 'bike',
                        groupValue: controller.selectedRoute.value,
                        onChanged: (value) {
                          controller.selectedRoute.value = value.toString();
                        },
                      ),
                      Row(
                        children: [
                          Icon(Icons.directions_bike),
                        ],
                      ),
                    ],
                  )),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 10),
                              Text("Please Wait Getting Routes"),
                            ],
                          ),
                          duration: Duration(seconds: 20),
                        ),
                      );

                      controller.search(controller.selectedRoute.value).then((_) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    },
                    child: Text('Search'),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildDestinationTextField(TextEditingController controller, String labelText, IconData icon, VoidCallback? onTap) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon),
          ),
        ),
      );
    }
  }






