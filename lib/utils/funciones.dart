// funciones.dart

import 'package:aviancataxi/RegistroExcelPage.dart';
import 'package:aviancataxi/registro_recorrido.dart';
import 'package:aviancataxi/soporte/soporte.dart';
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

void mostrarSoporte(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SupportPage(),
    ),
  );
}

// NUEVA FUNCIÓN PARA REGISTROS EXCEL
void irARegistroExcel(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegistroExcelPage(),
    ),
  );
}
