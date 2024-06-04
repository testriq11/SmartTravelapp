// import 'package:flutter/material.dart';
// import 'package:smarttravelapp/home/controller/home_controller.dart';
// import 'package:smarttravelapp/home/view/home_screen.dart';
//
// import '../../home/view/home_screen.dart';
//

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controller/signup_controller.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignUpController _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => _controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () {
                _controller.signUp(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: const Text('Sign Up'),
            )),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Implement Google sign-up
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              label: const Text('Sign Up with Google'),
            ),
          ],
        ),
      ),
    );
  }
}

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(20.0),
//         child: SignUpForm(),
//       ),
//     );
//   }
// }
//
// class SignUpForm extends StatefulWidget {
//   const SignUpForm({Key? key}) : super(key: key);
//
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
//
// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>(); // Unique GlobalKey for SignUpForm
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   TextEditingController _mobileController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Name',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your name';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               labelText: 'Email ID',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your email';
//               }
//               // You can add more email validation logic here if needed
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Password',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your password';
//               }
//               // You can add more password validation logic here if needed
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             controller: _confirmPasswordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Confirm Password',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please confirm your password';
//               }
//               if (value != _passwordController.text) {
//                 return 'Passwords do not match';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             controller: _mobileController,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               labelText: 'Mobile Number',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your mobile number';
//               }
//               // You can add more mobile number validation logic here if needed
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 // Perform sign up operation
//                 String name = _nameController.text;
//                 String email = _emailController.text;
//                 String password = _passwordController.text;
//                 String mobile = _mobileController.text;
//                 // Implement your sign up logic here
//                 // After successful sign up, navigate to home screen
//                 Navigator.pop(context); // Go back to the previous screen (SignUpScreen)
//               }
//             },
//             child: const Text('Sign Up'),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // HomeController controller = HomeController();
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomeScreen()),
//               // );  // Implement Google sign up
//             },
//             child: const Text('Sign Up with Google'),
//           ),
//         ],
//       ),
//     );
//   }
// }
