import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets.dart'; // Assuming RegisterPage is imported from widgets.dart

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB0dDMiZb-0zRdiePQUcKXsIZ3i6NVul18",
            appId: "1:418598477332:web:f68b5cb7df5578a5dcd101",
            messagingSenderId: "418598477332",
            projectId: "loginapp01-26c29"));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<Map<String, String>> registeredUsers = [];

  void _login() {
    if (_formKey.currentState!.validate()) {
      String enteredEmail = _emailController.text.trim();
      String enteredPassword = _passwordController.text.trim();

      // Check if the entered email and password match any registered user
      bool isAuthenticated = registeredUsers.any((user) =>
          user['email'] == enteredEmail && user['password'] == enteredPassword);

      if (isAuthenticated) {
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: enteredEmail, // Pass the email as an argument
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[600],
      ),
      body: Center(
        child: SizedBox(
          height: 600,
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 45),
                  ),
                  const Text(
                    "Enter your email address to login.",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement sign in with Google functionality
                      },
                      child: const Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 253, 253, 253),
                        foregroundColor: const Color.fromARGB(255, 1, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(fontSize: 15)),
                      TextButton(
                        onPressed: () async {
                          // Navigate to RegisterPage and get back registeredUsers
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                  registeredUsers: registeredUsers),
                            ),
                          );

                          // Update registeredUsers if any new user is added
                          if (result != null) {
                            setState(() {
                              registeredUsers = result;
                            });
                          }
                        },
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
