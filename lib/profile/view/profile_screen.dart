import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with your image URL or asset
            ),
            SizedBox(height: 16),
            // Name
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Mobile number
            Text(
              '+1234567890',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 32),
            // Logout button
            ElevatedButton(
              onPressed: () {
                // Implement your logout functionality here
                Navigator.pop(context);
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
