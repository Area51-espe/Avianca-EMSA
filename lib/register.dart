import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    final nombre = _nombreController.text.trim();
    final apellido = _apellidoController.text.trim();
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      // Aquí podrías guardar los datos o conectar con backend/Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cuenta registrada: $nombre $apellido')),
      );

      // Redirigir al dashboard con el correo
      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
        arguments: {'email': email},
      );
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1C1C3A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
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
                    const Icon(Icons.person_add,
                        size: 80, color: Color(0xFF00FFFF)),
                    const SizedBox(height: 20),
                    const Text(
                      'Crear Cuenta',
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
                    buildTextField(
                      controller: _nombreController,
                      hintText: 'Nombre',
                      icon: Icons.person,
                      validator: (value) =>
                          value!.isEmpty ? 'Ingrese su nombre' : null,
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      controller: _apellidoController,
                      hintText: 'Apellido',
                      icon: Icons.person_outline,
                      validator: (value) =>
                          value!.isEmpty ? 'Ingrese su apellido' : null,
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Ingrese un email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      controller: _passwordController,
                      hintText: 'Contraseña',
                      icon: Icons.lock,
                      obscure: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _register,
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
                        'REGISTRARSE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        '¿Ya tienes cuenta? Inicia sesión',
                        style: TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
