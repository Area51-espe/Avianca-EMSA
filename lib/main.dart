import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración manual de Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyCFRnB5paigeA1UkUxovJEra7eKRulzthg", // Reemplaza con tu API Key real
      appId:
          "1:313384693994:android:5e5f745be19da865d76793", // Reemplaza con tu App ID real
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
      title: 'Proyecto Final', // Changed the app title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title: 'Proyecto Final'), // Changed the home page title
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Changed to StatelessWidget
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title), // Uses the title passed to the widget
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.home, // Home icon
              size: 100.0, // Adjust size as needed
              color: Colors.deepPurple, // Adjust color as needed
            ),
            const SizedBox(
                height: 20), // Adds some space between the icon and text
            Text(
              'Proyecto Final', // The desired text
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // Removed the floatingActionButton
    );
  }
}
