// styles.dart
import 'package:flutter/material.dart';

class AppStyles {
  // Colores principales
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color primaryBlueLight = Color(0xFF42A5F5);
  static const Color primaryBlueDark = Color(0xFF0D47A1);

  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);

  // Colores de estado
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);

  // Espaciado
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  // Tamaños de texto
  static const double textSizeSmall = 12.0;
  static const double textSizeMedium = 14.0;
  static const double textSizeLarge = 16.0;
  static const double textSizeXLarge = 20.0;
  static const double textSizeXXLarge = 24.0;

  // Estilos de texto
  static const TextStyle headingLarge = TextStyle(
    fontSize: textSizeXXLarge,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: textSizeXLarge,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: textSizeLarge,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: textSizeMedium,
    color: textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: textSizeSmall,
    color: textSecondary,
  );

  static const TextStyle captionText = TextStyle(
    fontSize: textSizeSmall,
    color: textHint,
  );

  // Decoraciones de contenedores
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration headerDecoration = BoxDecoration(
    color: primaryBlue.withOpacity(0.1),
    borderRadius: BorderRadius.circular(radiusMedium),
    border: Border.all(
      color: primaryBlue.withOpacity(0.3),
      width: 1,
    ),
  );

  // Tema de la aplicación
  static ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: textSizeXLarge,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        color: cardBackground,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingSmall,
          ),
        ),
      ),
    );
  }
}

// Clase para iconos personalizados
class AppIcons {
  static const IconData support = Icons.support_agent;
  static const IconData email = Icons.email;
  static const IconData phone = Icons.phone;
  static const IconData chat = Icons.chat;
  static const IconData bug = Icons.bug_report;
  static const IconData book = Icons.book;
  static const IconData video = Icons.video_library;
  static const IconData forum = Icons.forum;
  static const IconData faq = Icons.help_outline;
  static const IconData arrow = Icons.arrow_forward_ios;
}

// Datos de contacto
class ContactData {
  static const String email = 'soporte@empresa.com';
  static const String phone = '+593 2 123-4567';
  static const String workingHours = 'Lun-Vie 9:00-18:00';
  static const String responseTime = '24-48 horas';
}

// Preguntas frecuentes
class FAQData {
  static final List<Map<String, String>> faqs = [
    {
      'question': '¿Cómo puedo restablecer mi contraseña?',
      'answer':
          'Ve a la pantalla de inicio de sesión y toca "¿Olvidaste tu contraseña?". Te enviaremos un enlace por correo electrónico para restablecerla.',
    },
    {
      'question': '¿Cómo contacto con el soporte técnico?',
      'answer':
          'Puedes usar cualquiera de las opciones de contacto: email, teléfono, chat en vivo o enviar un ticket de soporte desde esta página.',
    },
    {
      'question': '¿Dónde encuentro mis facturas?',
      'answer':
          'Las facturas están disponibles en tu perfil de usuario, en la sección "Historial de pagos" donde podrás descargarlas en formato PDF.',
    },
    {
      'question': '¿Cómo actualizo mi información personal?',
      'answer':
          'Ve a tu perfil de usuario y selecciona "Editar información". Podrás cambiar tu nombre, email, teléfono y dirección.',
    },
    {
      'question': '¿La aplicación funciona sin internet?',
      'answer':
          'Algunas funciones básicas funcionan offline, pero necesitarás conexión a internet para sincronizar datos y acceder a todas las características.',
    },
  ];
}
