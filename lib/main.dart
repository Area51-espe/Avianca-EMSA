import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';
import 'home.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización manual de Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCFRnB5paigeA1UkUxovJEra7eKRulzthg",
      appId: "1:313384693994:android:5e5f745be19da865d76793",
      messagingSenderId: "313384693994",
      projectId: "appaviancaemsa",
    ),
  );

  print('Conexión a Firebase: ${Firebase.apps.isNotEmpty ? 'Éxito' : 'Falló'}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avianca EMSA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticación'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
