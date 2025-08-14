import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aviancataxi/src/backend/auth/login_page.dart';
import 'package:aviancataxi/src/frontend/registrar_recorrido_page.dart'; // Importa la página de registrar recorrido
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

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A40),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Panel de Control',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 10)],
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A40),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, size: 50, color: Colors.cyanAccent),
              const SizedBox(height: 20),
              Text(
                'Hola, ${user.email ?? "Usuario"}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Conectado al sistema',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              // Agregar botones con navegación a otras pantallas
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                shrinkWrap: true,
                itemCount: 4, // Aquí puedes agregar más botones si es necesario
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      // Aquí se asigna la navegación a cada pantalla
                      switch (index) {
                        case 0:
                          // Navegar al Home
                          Navigator.pushNamed(context, '/home');
                          break;
                        case 1:
                          // Navegar a Registros
                          // Navigator.pushNamed(context, '/registros');
                          break;
                        case 2:
                          // Navegar a Perfil
                          // Navigator.pushNamed(context, '/perfil');
                          break;
                        case 3:
                          // Navegar a Soporte
                          // Navigator.pushNamed(context, '/soporte');
                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      ['Inicio', 'Registros', 'Perfil', 'Soporte'][index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      // Agregar FloatingActionButton para registrar recorrido
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la página de registrar recorrido y pasar el user
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RegistrarRecorridoPage(user: user), // Pasamos el user aquí
            ),
          );
        },
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
