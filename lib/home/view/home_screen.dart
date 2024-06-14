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


  import 'dart:convert';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:smarttravelapp/constants/api_consts.dart';
  import 'package:smarttravelapp/home/controller/home_controller.dart';

  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:smarttravelapp/home/controller/home_controller.dart';

  // class HomeScreen extends StatelessWidget {
  //   final HomeController controller = Get.put(HomeController());
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     final arguments = Get.arguments;
  //     final String username = arguments['username'];
  //     final int id = arguments['id'];
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Home'),
  //       ),
  //       body: Center(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 // Display the username and id
  //                 Text('Welcome, $username!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //                 Text('Your ID is $id', style: TextStyle(fontSize: 16)),
  //                 SizedBox(height: 20),
  //
  //                 _buildDestinationTextField(controller.destinationController1, 'Current Location', Icons.my_location, () async {
  //                   await controller.getCurrentLocation();
  //                 }),
  //                 _buildDestinationTextField(controller.destinationController2, 'Search Destination 2', Icons.location_on, null),
  //                 SizedBox(height: 20),
  //                 Text('Preferred Route:', style: TextStyle(fontSize: 16)),
  //                 Obx(() => Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Radio(
  //                       value: 'car',
  //                       groupValue: controller.selectedRoute.value,
  //                       onChanged: (value) {
  //                         controller.selectedRoute.value = value.toString();
  //                       },
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(Icons.directions_car),
  //                       ],
  //                     ),
  //                     Radio(
  //                       value: 'bike',
  //                       groupValue: controller.selectedRoute.value,
  //                       onChanged: (value) {
  //                         controller.selectedRoute.value = value.toString();
  //                       },
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(Icons.directions_bike),
  //                       ],
  //                     ),
  //                   ],
  //                 )),
  //                 SizedBox(height: 20),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Row(
  //                           children: [
  //                             CircularProgressIndicator(),
  //                             SizedBox(width: 10),
  //                             Text("Please Wait Getting Routes"),
  //                           ],
  //                         ),
  //                         duration: Duration(seconds: 20),
  //                       ),
  //                     );
  //
  //                     controller.search(controller.selectedRoute.value).then((_) {
  //                       ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //                     });
  //                   },
  //                   child: Text('Search'),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildDestinationTextField(TextEditingController controller, String labelText, IconData icon, VoidCallback? onTap) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       child: TextField(
  //         controller: controller,
  //         onTap: onTap,
  //         decoration: InputDecoration(
  //           labelText: labelText,
  //           prefixIcon: Icon(icon),
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
  import 'package:http/http.dart' as http;
import '../../booking/view/booking_screen.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  // Define a global controller to manage and share state
  class GlobalController extends GetxController {
    var username = ''.obs;
    var id = 0.obs;

  // You can add more shared states or methods as needed
  }
  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    final HomeController controller = Get.put(HomeController());
    final GlobalController globalController = Get.put(GlobalController());
    int _selectedIndex = 0;

    late String username;
    late int id;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override
    void initState() {
      super.initState();
      _loadUserData();
    }
    void _loadUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username') ?? '';
        id = prefs.getInt('id') ?? 0;
      });
    }

    @override
    Widget build(BuildContext context) {
      final arguments = Get.arguments;
      final String username = arguments['username'];
      final int id = arguments['id'];

 final List<Widget> _widgetOptions = <Widget>[
        HomeView(username: username, id: id),
        BookingScreen(),
        ProfileView(id:id,username: username,),

        // BookingHistoryView(id: id),
      ];
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.teal,

        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Booking History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      );
    }
  }



  class HomeView extends StatelessWidget {
    final String username; // Declare username here
    final int id; // Declare id here

    // Constructor to receive username and id
    const HomeView({Key? key, required this.username, required this.id}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final HomeController controller = Get.find();

      return Scaffold(
        // appBar: AppBar(
        //   // title: const Text('Smart Travel Home'),
        //   // backgroundColor: Colors.teal,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, $username!',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                          ),
                          Text(
                            'Your ID is $id',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.currentPosition.value == null) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              controller.currentPosition.value!.latitude,
                              controller.currentPosition.value!.longitude,
                            ),
                            zoom: 14.0,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position: LatLng(
                                controller.currentPosition.value!.latitude,
                                controller.currentPosition.value!.longitude,
                              ),
                            ),
                          },
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(height: 20),
                _buildDestinationTextField(controller.destinationController1, 'Current Location', Icons.my_location, () async {
                  await controller.getCurrentLocation();
                }),
                _buildDestinationTextField(controller.destinationController2, 'Search Destination 2', Icons.location_on, null),
                SizedBox(height: 20),
                Text(
                  'Preferred Route:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
                    Icon(Icons.directions_car, color: Colors.teal),
                    Radio(
                      value: 'bike',
                      groupValue: controller.selectedRoute.value,
                      onChanged: (value) {
                        controller.selectedRoute.value = value.toString();
                      },
                    ),
                    Icon(Icons.directions_bike, color: Colors.teal),
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

                    controller.search(controller.selectedRoute.value, id).then((_) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      // Navigate to the BookingScreen1 with the ID passed as an argument
                      Get.toNamed('/booking', arguments: {'id': id});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Search', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildDestinationTextField(TextEditingController controller, String labelText, IconData icon, VoidCallback? onTap) {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: controller,
            onTap: onTap,
            decoration: InputDecoration(
              labelText: labelText,
              prefixIcon: Icon(icon),
              border: InputBorder.none,
            ),
          ),
        ),
      );
    }
  }


  // class HomeView extends StatelessWidget {
  //   final String username; // Declare username here
  //   final int id; // Declare id here
  //
  //   // Constructor to receive username and id
  //   const HomeView({Key? key, required this.username, required this.id}) : super(key: key);
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     final HomeController controller = Get.find();
  //
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text('Welcome, $username!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //             Text('Your ID is $id', style: TextStyle(fontSize: 16)),
  //             SizedBox(height: 20),
  //             Obx(() {
  //               if (controller.currentPosition.value == null) {
  //                 return CircularProgressIndicator();
  //               } else {
  //                 return Container(
  //                   height: 300,
  //                   child: GoogleMap(
  //                     initialCameraPosition: CameraPosition(
  //                       target: LatLng(
  //                         controller.currentPosition.value!.latitude,
  //                         controller.currentPosition.value!.longitude,
  //                       ),
  //                       zoom: 14.0,
  //                     ),
  //                     markers: {
  //                       Marker(
  //                         markerId: MarkerId('currentLocation'),
  //                         position: LatLng(
  //                           controller.currentPosition.value!.latitude,
  //                           controller.currentPosition.value!.longitude,
  //                         ),
  //                       ),
  //                     },
  //                   ),
  //                 );
  //               }
  //             }),
  //             _buildDestinationTextField(controller.destinationController1, 'Current Location', Icons.my_location, () async {
  //               await controller.getCurrentLocation();
  //             }),
  //             _buildDestinationTextField(controller.destinationController2, 'Search Destination 2', Icons.location_on, null),
  //             SizedBox(height: 20),
  //             Text('Preferred Route:', style: TextStyle(fontSize: 16)),
  //             Obx(() => Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Radio(
  //                   value: 'car',
  //                   groupValue: controller.selectedRoute.value,
  //                   onChanged: (value) {
  //                     controller.selectedRoute.value = value.toString();
  //                   },
  //                 ),
  //                 Icon(Icons.directions_car),
  //                 Radio(
  //                   value: 'bike',
  //                   groupValue: controller.selectedRoute.value,
  //                   onChanged: (value) {
  //                     controller.selectedRoute.value = value.toString();
  //                   },
  //                 ),
  //                 Icon(Icons.directions_bike),
  //               ],
  //             )),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Row(
  //                       children: [
  //                         CircularProgressIndicator(),
  //                         SizedBox(width: 10),
  //                         Text("Please Wait Getting Routes"),
  //                       ],
  //                     ),
  //                     duration: Duration(seconds: 20),
  //                   ),
  //                 );
  //
  //                 controller.search(controller.selectedRoute.value, id).then((_) {
  //                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //                   // Navigate to the BookingScreen1 with the ID passed as an argument
  //                   Get.toNamed('/booking', arguments: {'id': id});
  //                 });
  //               },
  //               child: Text('Search'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildDestinationTextField(TextEditingController controller, String labelText, IconData icon, VoidCallback? onTap) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       child: TextField(
  //         controller: controller,
  //         onTap: onTap,
  //         decoration: InputDecoration(
  //           labelText: labelText,
  //           prefixIcon: Icon(icon),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // class ProfileView extends StatelessWidget {
  //   @override
  //   Widget build(BuildContext context) {
  //     return Center(
  //       child: Text('Profile Page', style: TextStyle(fontSize: 20)),
  //     );
  //   }
  // }

  class ProfileView extends StatelessWidget {
    final int id;
    final String username;
    const ProfileView({super.key, required this.id, required this.username});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Get.toNamed('/profiledetails', arguments: {'id': id,'username':username});
              },
            ),
            ListTile(
              title: const Text('My Trips'),
              onTap: () {
                // Navigate to my trips screen
                Get.toNamed('/bookingHistory', arguments: {'id': id});
              },
            ),
            ListTile(
              title: const Text('My Bookings'),
              onTap: () {
                // Navigate to my bookings screen

              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Get.toNamed('/setting');
              },
            ),
            ListTile(
              title: const Text('Share App'),
              onTap: () {
                // Navigate to share app screen
              },
            ),
            ListTile(
              title: const Text('Rate App'),
              onTap: () {
                // Redirect to play store for rating
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                // Navigate to help/chat screen
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
                // Navigate to contact us screen
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Implement logout functionality
              },
            ),
          ],
        ),
      );
    }
  }

  class BookingScreen extends StatelessWidget {
    const BookingScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Hotels'),
              onTap: () {
                // Navigate to hotels list screen
              },
            ),
            ListTile(
              title: const Text('Flights'),
              onTap: () {
                // Navigate to flights screen

              },
            ),
            ListTile(
              title: const Text('Trains'),
              onTap: () {
                // Navigate to trains screen
              },
            ),
            ListTile(
              title: const Text('Restaurants'),
              onTap: () {
                // Navigate to restaurants list screen
              },
            ),
          ],
        ),
      );
    }
  }


  class BookingHistoryView extends StatefulWidget {
    final int id;
    const BookingHistoryView({Key? key, required this.id}) : super(key: key);

    @override
    _BookingHistoryViewState createState() => _BookingHistoryViewState();
  }

  class _BookingHistoryViewState extends State<BookingHistoryView> {
    List<dynamic> responseData = [];
    bool isLoading = true;
    String errorMessage = '';

    @override
    void initState() {
      super.initState();
      fetchBookingHistory();
    }

    Future<void> fetchBookingHistory() async {
      final url = '$NGROK_URL/booking_history/responses/${widget.id}';
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          setState(() {
            responseData = json.decode(response.body);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Error: ${response.statusCode}';
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to load data: $e';
          isLoading = false;
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      // Group response data by title
      Map<String, List<String>> groupedData = {};
      responseData.forEach((data) {
        String title = data['title'];
        String text = data['text'];
        if (!groupedData.containsKey(title)) {
          groupedData[title] = [];
        }
        groupedData[title]!.add(text);
      });

      return Center(
        child: isLoading
            ? CircularProgressIndicator()
            : errorMessage.isNotEmpty
            ? Text(
          errorMessage,
          style: TextStyle(fontSize: 16, color: Colors.red),
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Trip History', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('User ID: ${widget.id}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Column(
                children: groupedData.entries.map((entry) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(
                          entry.key,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: entry.value.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    entry.value[index] ?? '',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }
  }
