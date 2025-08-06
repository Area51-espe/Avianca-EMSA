// funciones.dart

import 'package:aviancataxi/registro_recorrido.dart';
import 'package:flutter/material.dart';
// Asegúrate de que la ruta es correcta

void irARegistroRecorrido(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegistroRecorridoScreen(),
    ),
  );
}
