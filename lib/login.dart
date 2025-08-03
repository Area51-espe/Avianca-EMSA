import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      // Validación simple simulada (puedes reemplazar con Firebase luego)
      if (email == 'admin' && pass == '1234') {
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
          arguments: {'email': email},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.lock, size: 80, color: Color(0xFF00FFFF)),
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.cyanAccent,
                            offset: Offset(1, 1),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Colors.cyanAccent),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color(0xFF1C1C3A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Ingrese su email' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.cyanAccent),
                        hintText: 'Contraseña',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color(0xFF1C1C3A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Ingrese su contraseña' : null,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FFFF),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 10,
                        shadowColor: Colors.cyanAccent,
                      ),
                      child: const Text(
                        'INICIAR SESIÓN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        '¿No tienes cuenta? Regístrate',
                        style: TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
