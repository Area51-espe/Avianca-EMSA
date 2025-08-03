import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aviancataxi/src/backend/auth/login_page.dart';
import 'package:aviancataxi/src/frontend/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ← MUY IMPORTANTE

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avianca App',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Si está autenticado, va directo al HomePage
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            return user != null ? HomePage(user: user) : const LoginPage();
          }
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
