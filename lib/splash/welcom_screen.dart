import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/login/view/login_screen.dart';

import '../home/view/home_screen.dart';
import '../login/view/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _checkUserData(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           if (snapshot.data == true) {
//             // If user data exists, navigate to HomeScreen with arguments
//             return HomeScreen();
//           } else {
//             // If no user data, show welcome screen with login/signup options
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('Welcome to Smart Travel'),
//                 backgroundColor: Colors.teal,
//               ),
//               body: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               Get.toNamed('/login'); // Navigate to login screen
//                             },
//                             icon: Icon(Icons.login),
//                             label: const Text('Login'),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.teal,
//                               onPrimary: Colors.white,
//                               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                               textStyle: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               Get.toNamed('/signup'); // Navigate to sign up screen
//                             },
//                             icon: Icon(Icons.person_add),
//                             label: const Text('Sign Up'),
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.teal,
//                               onPrimary: Colors.white,
//                               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                               textStyle: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       GestureDetector(
//                         onTap: () {
//                           // _launchURL('https://your-terms-and-conditions-url.com');
//                         },
//                         child: const Text(
//                           'Terms and Conditions',
//                           style: TextStyle(
//                             color: Colors.teal,
//                             fontSize: 16,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: () {
//                           // _launchURL('https://your-privacy-policy-url.com');
//                         },
//                         child: const Text(
//                           'Privacy Policy',
//                           style: TextStyle(
//                             color: Colors.teal,
//                             fontSize: 16,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         }
//       },
//     );
//   }
//
//   Future<bool> _checkUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? username = prefs.getString('username');
//     int? id = prefs.getInt('id');
//     return username != null && id != null;
//   }
// }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  void initState() {
    super.initState();

    _checkUserLoggedIn(); // Check if user is already logged in
  }

  void _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    int? id = prefs.getInt('id');
    String? email = prefs.getString('email');

    if (username != null && id != null && email != null) {
      Get.offAllNamed('/home', arguments: {
        'id': id,
        'username': username,
        'email': email,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Smart Travel'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed('/login'); // Navigate to login screen
                    },
                    icon: Icon(Icons.login),
                    label: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed('/signup'); // Navigate to sign up screen
                    },
                    icon: Icon(Icons.person_add),
                    label: const Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // _launchURL('https://your-terms-and-conditions-url.com');
                },
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // _launchURL('https://your-privacy-policy-url.com');
                },
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


////**********imp
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome to Smart Travel'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Get.toNamed('/login'); // Navigate to login screen
//                     },
//                     icon: Icon(Icons.login),
//                     label: const Text('Login'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.teal,
//                       onPrimary: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Get.toNamed('/signup'); // Navigate to sign up screen
//                     },
//                     icon: Icon(Icons.person_add),
//                     label: const Text('Sign Up'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.teal,
//                       onPrimary: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () {
//                   // _launchURL('https://your-terms-and-conditions-url.com');
//                 },
//                 child: const Text(
//                   'Terms and Conditions',
//                   style: TextStyle(
//                     color: Colors.teal,
//                     fontSize: 16,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   // _launchURL('https://your-privacy-policy-url.com');
//                 },
//                 child: const Text(
//                   'Privacy Policy',
//                   style: TextStyle(
//                     color: Colors.teal,
//                     fontSize: 16,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

////**********imp