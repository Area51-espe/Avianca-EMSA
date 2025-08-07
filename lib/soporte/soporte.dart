// support_page.dart
import 'package:flutter/material.dart';
// import 'styles.dart'; // Descomenta esta línea en tu proyecto

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Soporte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppStyles.paddingLarge),
            _buildFAQSection(),
            const SizedBox(height: AppStyles.paddingXLarge),
            _buildContactSection(context),
            const SizedBox(height: AppStyles.paddingXLarge),
            _buildResourcesSection(context),
            const SizedBox(height: AppStyles.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppStyles.paddingLarge),
      decoration: AppStyles.headerDecoration,
      child: Column(
        children: [
          Icon(
            AppIcons.support,
            size: 48,
            color: AppStyles.primaryBlue,
          ),
          const SizedBox(height: AppStyles.paddingSmall),
          const Text(
            '¿Necesitas ayuda?',
            style: AppStyles.headingLarge,
          ),
          const SizedBox(height: AppStyles.paddingSmall),
          Text(
            'Estamos aquí para ayudarte. Encuentra respuestas rápidas o contáctanos directamente.',
            textAlign: TextAlign.center,
            style: AppStyles.bodyLarge.copyWith(
              color: AppStyles.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Preguntas Frecuentes', style: AppStyles.headingMedium),
        const SizedBox(height: AppStyles.paddingSmall),
        ...FAQData.faqs.map((faq) => FAQCard(
              question: faq['question']!,
              answer: faq['answer']!,
            )),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Opciones de Contacto', style: AppStyles.headingMedium),
        const SizedBox(height: AppStyles.paddingMedium),
        Row(
          children: [
            Expanded(
              child: ContactCard(
                icon: AppIcons.email,
                title: 'Email',
                subtitle: ContactData.email,
                color: AppStyles.successGreen,
                onTap: () => _showContactDialog(context, 'Contacto por Email',
                    'Envíanos un correo a:\n${ContactData.email}\n\nTiempo de respuesta: ${ContactData.responseTime}'),
              ),
            ),
            const SizedBox(width: AppStyles.paddingSmall),
            Expanded(
              child: ContactCard(
                icon: AppIcons.phone,
                title: 'Teléfono',
                subtitle: ContactData.phone,
                color: AppStyles.warningOrange,
                onTap: () => _showContactDialog(context, 'Contacto Telefónico',
                    'Llámanos al:\n${ContactData.phone}\n\nHorario: ${ContactData.workingHours}'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.paddingSmall),
        Row(
          children: [
            Expanded(
              child: ContactCard(
                icon: AppIcons.chat,
                title: 'Chat en Vivo',
                subtitle: 'Disponible 24/7',
                color: AppStyles.infoBlue,
                onTap: () => _showContactDialog(context, 'Chat en Vivo',
                    'Nuestro chat está disponible 24/7.\n\n¡Habla con un agente ahora mismo!'),
              ),
            ),
            const SizedBox(width: AppStyles.paddingSmall),
            Expanded(
              child: ContactCard(
                icon: AppIcons.bug,
                title: 'Reportar Bug',
                subtitle: 'Informa problemas',
                color: AppStyles.errorRed,
                onTap: () => _showContactDialog(context, 'Reportar Bug',
                    'Gracias por ayudarnos a mejorar.\n\nDescribe el problema que encontraste y te contactaremos pronto.'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResourcesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recursos Adicionales', style: AppStyles.headingMedium),
        const SizedBox(height: AppStyles.paddingMedium),
        ResourceCard(
          icon: AppIcons.book,
          title: 'Documentación',
          description: 'Guías detalladas y tutoriales',
          onTap: () => _showContactDialog(context, 'Documentación',
              'Accede a nuestra documentación completa con guías paso a paso.'),
        ),
        ResourceCard(
          icon: AppIcons.video,
          title: 'Videos Tutoriales',
          description: 'Aprende visualmente con nuestros videos',
          onTap: () => _showContactDialog(context, 'Videos Tutoriales',
              'Próximamente: biblioteca de videos tutoriales.'),
        ),
        ResourceCard(
          icon: AppIcons.forum,
          title: 'Comunidad',
          description: 'Únete a la discusión con otros usuarios',
          onTap: () => _showContactDialog(context, 'Comunidad',
              'Únete a nuestro foro de comunidad para compartir experiencias.'),
        ),
      ],
    );
  }

  void _showContactDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

// Widgets componentes
class FAQCard extends StatefulWidget {
  final String question;
  final String answer;

  const FAQCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQCardState createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppStyles.paddingSmall),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: AppStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppStyles.paddingMedium),
            child: Text(
              widget.answer,
              style: AppStyles.bodyMedium.copyWith(
                color: AppStyles.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const ContactCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.paddingMedium),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: AppStyles.paddingSmall),
              Text(
                title,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ResourceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppStyles.primaryBlue.withOpacity(0.1),
          child: Icon(icon, color: AppStyles.primaryBlue),
        ),
        title: Text(
          title,
          style: AppStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(description, style: AppStyles.bodySmall),
        trailing: const Icon(AppIcons.arrow, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Clases de estilos y datos (incluidas para funcionar standalone)
class AppStyles {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  static const double radiusMedium = 12.0;

  static const double textSizeLarge = 16.0;
  static const double textSizeXLarge = 20.0;
  static const double textSizeXXLarge = 24.0;
  static const double textSizeMedium = 14.0;
  static const double textSizeSmall = 12.0;

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

  static BoxDecoration headerDecoration = BoxDecoration(
    color: primaryBlue.withOpacity(0.1),
    borderRadius: BorderRadius.circular(radiusMedium),
    border: Border.all(
      color: primaryBlue.withOpacity(0.3),
      width: 1,
    ),
  );
}

class AppIcons {
  static const IconData support = Icons.support_agent;
  static const IconData email = Icons.email;
  static const IconData phone = Icons.phone;
  static const IconData chat = Icons.chat;
  static const IconData bug = Icons.bug_report;
  static const IconData book = Icons.book;
  static const IconData video = Icons.video_library;
  static const IconData forum = Icons.forum;
  static const IconData arrow = Icons.arrow_forward_ios;
}

class ContactData {
  static const String email = 'soporte@empresa.com';
  static const String phone = '+593 2 123-4567';
  static const String workingHours = 'Lun-Vie 9:00-18:00';
  static const String responseTime = '24-48 horas';
}

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
  ];
}
