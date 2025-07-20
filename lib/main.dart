import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Final', // Changed the app title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Proyecto Final'), // Changed the home page title
    );
  }
}

class MyHomePage extends StatelessWidget { // Changed to StatelessWidget
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
            const SizedBox(height: 20), // Adds some space between the icon and text
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