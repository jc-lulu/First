import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    void _logout(BuildContext context) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (Route<dynamic> route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.green[600],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to your profile!'),
            const SizedBox(height: 20),
            Text('Email: $email', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
