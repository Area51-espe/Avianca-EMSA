import 'package:flutter/material.dart';
import 'registro_recorrido.dart'; // Asegúrate de que la ruta del archivo sea correcta

class DashboardScreen extends StatelessWidget {
  final String userEmail;

  const DashboardScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F2C),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Panel de Control",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/car_banner.png', // Usa tu imagen aquí
                  fit: BoxFit.cover,
                  height: 160,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2039),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.cyanAccent,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hola,", style: TextStyle(color: Colors.white)),
                          Text(
                            userEmail,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Conectado al sistema",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.bolt, color: Colors.cyanAccent),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildTile(Icons.dashboard_customize, "Inicio", Colors.blueAccent),
                  _buildTile(Icons.receipt_long, "Registros", const Color(0xFF1C2039)),
                  _buildTile(Icons.person, "Perfil", const Color(0xFF1C2039)),
                  _buildTile(Icons.headset_mic, "Soporte", const Color(0xFF1C2039)),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0B0F2C),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, color: Colors.cyanAccent),
            SizedBox(width: 40), // espacio para botón central
            Icon(Icons.logout, color: Colors.cyanAccent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistroRecorridoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTile(IconData icon, String title, Color backgroundColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.cyanAccent),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
