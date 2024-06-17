import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:smarttravelapp/constants/api_consts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smarttravelapp/login/controller/signup_controller.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late SignUpController signUpController; // Declare SignUpController instance

  @override
  void onInit() {
    super.onInit();
    signUpController = SignUpController();
    _checkUserLoggedIn();// Initialize SignUpController
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
        'email': email
      });
    }
  }

  // void login() async {
  //   if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
  //     isLoading.value = true;
  //
  //     try {
  //       final response = await http.post(
  //         Uri.parse('$NGROK_URL/login/login'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, String>{
  //           'email': emailController.text,
  //           'password': passwordController.text,
  //         }),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = json.decode(response.body);
  //         if (responseData['success'] == true) {
  //           isLoading.value = false;
  //
  //           Get.offAllNamed('/home', arguments: {
  //             'id': responseData['user']['id'],
  //             'username': responseData['user']['username'],
  //             'email': responseData['user']['email']
  //           });
  //         } else {
  //           isLoading.value = false;
  //           Get.snackbar('Error', responseData['error'],
  //               snackPosition: SnackPosition.BOTTOM);
  //         }
  //       } else {
  //         isLoading.value = false;
  //         Get.snackbar('Error', 'Server error',
  //             snackPosition: SnackPosition.BOTTOM);
  //       }
  //     } catch (e) {
  //       isLoading.value = false;
  //       print('Exception occurred: $e');
  //       Get.snackbar('Error', 'An error occurred',
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } else {
  //     Get.snackbar('Error', 'Please enter email and password',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        final response = await http.post(
          Uri.parse('$NGROK_URL/login/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['success'] == true) {
            isLoading.value = false;

            // Save user data in SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('username', responseData['user']['username']);
            await prefs.setInt('id', responseData['user']['id']);
            await prefs.setString('email', responseData['user']['email']);

            Get.offAllNamed('/home', arguments: {
              'id': responseData['user']['id'],
              'username': responseData['user']['username'],
              'email': responseData['user']['email']
            });
          } else {
            isLoading.value = false;
            Get.snackbar('Error', responseData['error'],
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          isLoading.value = false;
          Get.snackbar('Error', 'Server error',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        isLoading.value = false;
        print('Exception occurred: $e');
        Get.snackbar('Error', 'An error occurred',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Please enter email and password',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void newlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';

    if (savedEmail.isNotEmpty) {
      isLoading.value = true;

      try {
        final response = await http.post(
          Uri.parse('$NGROK_URL/login/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': savedEmail,
            'password': '123',
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['success'] == true) {
            isLoading.value = false;

            Get.offAllNamed('/home', arguments: {
              'id': responseData['user']['id'],
              'username': responseData['user']['username'],
              'email': responseData['user']['email']
            });
          } else {
            isLoading.value = false;
            print('Error: ${responseData['error']}');
          }
        } else {
          isLoading.value = false;
          print('Server error');
        }
      } catch (e) {
        isLoading.value = false;
        print('Exception occurred: $e');
      }
    } else {
      print('No saved email found');
    }
  }


  // void newlogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String savedEmail = prefs.getString('email') ?? '';
  //
  //   if (savedEmail.isNotEmpty) {
  //     isLoading.value = true;
  //
  //     try {
  //       final response = await http.post(
  //         Uri.parse('$NGROK_URL/login/login'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, String>{
  //           'email': savedEmail,
  //           'password': '123',
  //         }),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = json.decode(response.body);
  //         if (responseData['success'] == true) {
  //           isLoading.value = false;
  //
  //           Get.offAllNamed('/home', arguments: {
  //             'id': responseData['user']['id'],
  //             'username': responseData['user']['username'],
  //             'email': responseData['user']['email']
  //           });
  //         } else {
  //           isLoading.value = false;
  //           Get.snackbar('Error', responseData['error'],
  //               snackPosition: SnackPosition.BOTTOM);
  //         }
  //       } else {
  //         isLoading.value = false;
  //         Get.snackbar('Error', 'Server error',
  //             snackPosition: SnackPosition.BOTTOM);
  //       }
  //     } catch (e) {
  //       isLoading.value = false;
  //       print('Exception occurred: $e');
  //       Get.snackbar('Error', 'An error occurred',
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } else {
  //     Get.snackbar('Error', 'No saved email found',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  void googleLogin() async {
    print("Google login method called");

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        print('Google Auth ID Token: ${googleAuth.idToken}');
        print('Google Auth Access Token: ${googleAuth.accessToken}');
        print('id: ${googleUser.id}');
        print('username: ${googleUser.displayName}');
        print('email: ${googleUser.email}');

        String username = googleUser.displayName ?? '';
        String email = googleUser.email ?? '';

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Check if user data is already saved in SharedPreferences
        String? savedUsername = prefs.getString('username');
        String? savedEmail = prefs.getString('email');

        if (savedUsername == username && savedEmail == email) {
          print('User already logged in.');
          newlogin(); // Attempt to log in
          try {
            Map<String, dynamic> responseData = await getResponseData();
            if (responseData.containsKey('user')) {
              await prefs.setInt('id', responseData['user']['id']);
              await prefs.setString('username', responseData['user']['username']);
              await prefs.setString('email', responseData['user']['email']);
              Get.offAllNamed('/home', arguments: {
                'id': responseData['user']['id'],
                'username': responseData['user']['username'],
                'email': responseData['user']['email']
              });
            } else {
              print('User data not found');
            }
          } catch (e) {
            print('Exception occurred while fetching user data: $e');
          }
          return; // Exit the function early
        }

        // Call signUpController.signUp() asynchronously
        bool signUpSuccess = await signUpController.signUp(username, email, '123');

        if (signUpSuccess) {
          // Save user data in SharedPreferences after successful signup
          await prefs.setString('username', username);
          await prefs.setString('email', email);

          // Proceed with login attempt after signing up (whether successful or not)
          newlogin(); // Call your login method

          // Retrieve responseData after login
          try {
            Map<String, dynamic> responseData = await getResponseData();
            if (responseData.containsKey('user')) {
              // Save user data in SharedPreferences after successful login
              await prefs.setInt('id', responseData['user']['id']);
              await prefs.setString('username', responseData['user']['username']);
              await prefs.setString('email', responseData['user']['email']);

              // Navigate to home screen with user data
              Get.offAllNamed('/home', arguments: {
                'id': responseData['user']['id'],
                'username': responseData['user']['username'],
                'email': responseData['user']['email']
              });
            } else {
              print('User data not found');
            }
          } catch (e) {
            print('Exception occurred while fetching user data: $e');
          }
        } else {
          print('Failed to sign up user');
        }
      } else {
        print('Google sign-in failed.');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }



  // void googleLogin() async {
  //   print("Google login method called");
  //
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //       print('Google Auth ID Token: ${googleAuth.idToken}');
  //       print('Google Auth Access Token: ${googleAuth.accessToken}');
  //       print('id: ${googleUser.id}');
  //       print('username: ${googleUser.displayName}');
  //       print('email: ${googleUser.email}');
  //
  //       String username = googleUser.displayName ?? '';
  //       String email = googleUser.email ?? '';
  //
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('username', username);
  //       await prefs.setString('email', email);
  //
  //       // Call signUpController.signUp() asynchronously
  //       bool signUpSuccess = await signUpController.signUp(username, email, '123');
  //
  //       if (signUpSuccess) {
  //         // Save user data in SharedPreferences after successful signup
  //         await prefs.setString('username', username);
  //         await prefs.setString('email', email);
  //
  //         // Proceed with login attempt after signing up (whether successful or not)
  //         newlogin(); // Call your login method
  //
  //         // Retrieve responseData after login
  //         Map<String, dynamic> responseData = await getResponseData();
  //
  //         if (responseData.containsKey('user')) {
  //           // Save user data in SharedPreferences after successful login
  //           await prefs.setInt('id', responseData['user']['id']);
  //           await prefs.setString('username', responseData['user']['username']);
  //           await prefs.setString('email', responseData['user']['email']);
  //
  //           // Navigate to home screen with user data
  //           Get.offAllNamed('/home', arguments: {
  //             'id': responseData['user']['id'],
  //             'username': responseData['user']['username'],
  //             'email': responseData['user']['email']
  //           });
  //         } else {
  //           // Handle case where responseData doesn't contain expected user data
  //           Get.snackbar('Error', 'User data not found',
  //               snackPosition: SnackPosition.BOTTOM);
  //         }
  //       } else {
  //         print('Failed to sign up user');
  //         Get.snackbar('Error', 'Failed to sign up user',
  //             snackPosition: SnackPosition.BOTTOM);
  //       }
  //     } else {
  //       print('Google sign-in failed.');
  //     }
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //     Get.snackbar('Error', 'Failed to sign in with Google',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  // void googleLogin() async {
  //   print("Google login method called");
  //
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //       print('Google Auth ID Token: ${googleAuth.idToken}');
  //       print('Google Auth Access Token: ${googleAuth.accessToken}');
  //       print('id: ${googleUser.id}');
  //       print('username: ${googleUser.displayName}');
  //       print('email: ${googleUser.email}');
  //
  //       String username = googleUser.displayName ?? '';
  //       String email = googleUser.email ?? '';
  //
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('username', username);
  //       await prefs.setString('email', email);
  //
  //       // Call signUpController.signUp() asynchronously
  //       bool signUpSuccess = await signUpController.signUp(username, email, '123');
  //
  //       if (signUpSuccess) {
  //         // Proceed with login attempt after signing up (whether successful or not)
  //       newlogin(); // Call your login method
  //
  //         // Retrieve responseData after login
  //         Map<String, dynamic> responseData = await getResponseData();
  //
  //         if (responseData.containsKey('user')) {
  //           // Navigate to home screen with user data
  //           Get.offAllNamed('/home', arguments: {
  //             'id': responseData['user']['id'],
  //             'username': responseData['user']['username'],
  //             'email': responseData['user']['email']
  //           });
  //         } else {
  //           // Handle case where responseData doesn't contain expected user data
  //           Get.snackbar('Error', 'User data not found',
  //               snackPosition: SnackPosition.BOTTOM);
  //         }
  //       } else {
  //         print('Failed to sign up user');
  //         Get.snackbar('Error', 'Failed to sign up user',
  //             snackPosition: SnackPosition.BOTTOM);
  //       }
  //     } else {
  //       print('Google sign-in failed.');
  //     }
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //     Get.snackbar('Error', 'Failed to sign in with Google',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }



  Future<Map<String, dynamic>> getResponseData() async {
    // Implement your logic to fetch responseData after login
    // Example: Make an HTTP request to fetch user data after successful login
    // Modify this according to your actual backend API response structure
    try {
      final response = await http.get(Uri.parse('$NGROK_URL/user'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Exception occurred while fetching user data: $e');
      throw e; // Propagate the error to handle it in googleLogin()
    }
  }



  Future<void> saveCredentials(String username, String email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('email', email);
    } catch (e) {
      print('Error saving credentials: $e');
      Get.snackbar('Error', 'Failed to save credentials',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


}





// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   void login() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       isLoading.value = true;
//
//       try {
//         final response = await http.post(
//           Uri.parse('$NGROK_URL/login/login'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'email': emailController.text,
//             'password': passwordController.text,
//           }),
//         );
//
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           if (responseData['success'] == true) {
//             isLoading.value = false;
//
//             Get.offAllNamed('/home', arguments: {
//               'id': responseData['user']['id'],
//               'username': responseData['user']['username'],
//               'email': responseData['user']['email']
//             });
//           } else {
//             isLoading.value = false;
//             Get.snackbar('Error', responseData['error'],
//                 snackPosition: SnackPosition.BOTTOM);
//           }
//         } else {
//           isLoading.value = false;
//           Get.snackbar('Error', 'Server error',
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       } catch (e) {
//         isLoading.value = false;
//         print('Exception occurred: $e');
//         Get.snackbar('Error', 'An error occurred',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter email and password',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   void googleLogin() async {
//     print("Google login method called");
//
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;
//
//         // Now you can use googleAuth.idToken to authenticate with your server
//         // or use googleAuth.accessToken to access Google APIs
//         print('Google Auth ID Token: ${googleAuth.idToken}');
//         print('Google Auth Access Token: ${googleAuth.accessToken}');
//         print('id: ${googleUser.id}');
//         print('username: ${googleUser.displayName}');
//         print('email: ${googleUser.email}');
//         // Example of how to proceed with Google sign-in
//         // Replace with your own logic
//         Get.offAllNamed('/home', arguments: {
//           'id': googleUser.id,
//           'username': googleUser.displayName ?? '',
//           'email': googleUser.email,
//           'profilePic': googleUser.photoUrl ?? ''
//         });
//       } else {
//         print('Google sign-in failed.');
//       }
//     } catch (error) {
//       print('Error signing in with Google: $error');
//       Get.snackbar('Error', 'Failed to sign in with Google',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//
// }

//
// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   void login() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       isLoading.value = true;
//
//       try {
//         final response = await http.post(
//           Uri.parse('$NGROK_URL/login/login'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'email': emailController.text,
//             'password': passwordController.text,
//           }),
//         );
//
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           if (responseData['success'] == true) {
//             isLoading.value = false;
//
//             Get.offAllNamed('/home', arguments: {
//               'id': responseData['user']['id'],
//               'username': responseData['user']['username'],
//               'email': responseData['user']['email']
//             });
//           } else {
//             isLoading.value = false;
//             Get.snackbar('Error', responseData['error'],
//                 snackPosition: SnackPosition.BOTTOM);
//           }
//         } else {
//           isLoading.value = false;
//           Get.snackbar('Error', 'Server error',
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       } catch (e) {
//         isLoading.value = false;
//         print('Exception occurred: $e');
//         Get.snackbar('Error', 'An error occurred',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter email and password',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> googleLogin() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return; // User canceled login
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final idToken = googleAuth.idToken;
//
//       final response = await http.post(
//         Uri.parse('https://6104-202-179-91-72.ngrok-free.app/google_login/google_login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'idToken': idToken!,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if (responseData['success'] == true) {
//           isLoading.value = false;
//
//           Get.offAllNamed('/home', arguments: {
//             'id': responseData['user']['id'],
//             'username': responseData['user']['username'],
//             'email': responseData['user']['email']
//           });
//         } else {
//           isLoading.value = false;
//           Get.snackbar('Error', responseData['error'],
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       } else {
//         isLoading.value = false;
//         Get.snackbar('Error', 'Server error',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (error) {
//       isLoading.value = false;
//       print('Exception occurred: $error');
//       Get.snackbar('Error', 'An error occurred',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }

// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//
//   void login() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       isLoading.value = true; // Set loading to true during login process
//
//       try {
//         final response = await http.post(
//           Uri.parse('$NGROK_URL/login/login'), // Replace with your API endpoint
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'email': emailController.text,
//             'password': passwordController.text,
//           }),
//         );
//
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           if (responseData['success'] == true) {
//             isLoading.value = false; // Set loading to false after successful login
//
//             // Navigate to HomeScreen and pass user data
//             Get.offAllNamed('/home', arguments: {
//               'id': responseData['user']['id'],
//               'username': responseData['user']['username'],
//               'email': responseData['user']['email']
//             });
//           } else {
//             isLoading.value = false; // Set loading to false if login failed
//             Get.snackbar('Error', responseData['error'],
//                 snackPosition: SnackPosition.BOTTOM);
//           }
//         } else {
//           isLoading.value = false; // Set loading to false if server error occurred
//           Get.snackbar('Error', 'Server error',
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       } catch (e) {
//         isLoading.value = false; // Set loading to false if an exception occurred
//         print('Exception occurred: $e');
//         Get.snackbar('Error', 'An error occurred',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter email and password',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }

// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RxBool isLoading = false.obs;
//
//   void login() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       isLoading.value = true; // Set loading to true during login process
//
//       try {
//         final response = await http.post(
//           Uri.parse('https://17da-202-179-91-72.ngrok-free.app/login/login'), // Replace with your API endpoint
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'email': emailController.text,
//             'password': passwordController.text,
//           }),
//         );
//
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           if (responseData['success'] == true) {
//             isLoading.value = false; // Set loading to false after successful login
//             // Navigate to HomeScreen
//             Get.offAllNamed('/home');
//           } else {
//             isLoading.value = false; // Set loading to false if login failed
//             Get.snackbar('Error', responseData['error'],
//                 snackPosition: SnackPosition.BOTTOM);
//           }
//         } else {
//           isLoading.value = false; // Set loading to false if server error occurred
//           Get.snackbar('Error', 'Server error',
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       } catch (e) {
//         isLoading.value = false; // Set loading to false if an exception occurred
//         print('Exception occurred: $e');
//         Get.snackbar('Error', 'An error occurred',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter email and password',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }

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
