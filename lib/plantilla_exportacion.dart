import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/export_template.dart';

class PlantillaExportacionScreen extends StatefulWidget {
  const PlantillaExportacionScreen({super.key});
  @override
  State<PlantillaExportacionScreen> createState() => _PlantillaExportacionScreenState();
}

class _PlantillaExportacionScreenState extends State<PlantillaExportacionScreen> {
  DateTimeRange? rango;
  String? destino;
  TimeOfDay? hora;
  final _destinos = const ['Quito', 'Guayaquil', 'Cuenca', 'Latacunga'];

  Future<void> _pickRango() async {
    final h = DateTime.now();
    final r = await showDateRangePicker(
      context: context,
      firstDate: DateTime(h.year - 2),
      lastDate: DateTime(h.year + 2),
      initialDateRange: rango ??
          DateTimeRange(start: DateTime(h.year, h.month, h.day), end: DateTime(h.year, h.month, h.day)),
      builder: (c, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (r != null) setState(() => rango = r);
  }

  Future<void> _pickHora() async {
    final t = await showTimePicker(
      context: context,
      initialTime: hora ?? TimeOfDay.now(),
      builder: (c, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (t != null) setState(() => hora = t);
  }

  void _guardar() {
    if (rango == null) return _snack('Selecciona un rango de fechas.');
    if (destino == null) return _snack('Selecciona un destino.');

    final cfg = ExportTemplate(range: rango!, destination: destino!, time: hora);
    Navigator.pop(context, cfg); // ← retorno para usar en siguientes tareas
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    final cyan = Colors.cyanAccent;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A23),
        title: const Text('Plantilla de exportación', style: TextStyle(color: Colors.white)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: cyan), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _card('Rango de fechas', GestureDetector(
            onTap: _pickRango,
            child: _pickerRow(
              texto: rango == null
                  ? 'Selecciona un rango'
                  : '${DateFormat('dd/MM/yyyy').format(rango!.start)} — ${DateFormat('dd/MM/yyyy').format(rango!.end)}',
              icon: Icons.calendar_month,
            ),
          )),
          const SizedBox(height: 16),
          _card('Destino', DropdownButtonFormField<String>(
            value: destino,
            items: _destinos.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
            onChanged: (v) => setState(() => destino = v),
            dropdownColor: const Color(0xFF1C1C3A),
            decoration: const InputDecoration(border: InputBorder.none),
            iconEnabledColor: cyan,
            style: const TextStyle(color: Colors.white),
          )),
          const SizedBox(height: 16),
          _card('Hora (opcional)', GestureDetector(
            onTap: _pickHora,
            child: _pickerRow(
              texto: hora == null ? 'Selecciona una hora' : hora!.format(context),
              icon: Icons.access_time,
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _guardar,
              icon: const Icon(Icons.check, color: Colors.black),
              label: const Text('GUARDAR PLANTILLA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cyan, foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _card(String title, Widget child) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF1C2039), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12), child,
    ]),
  );

  Widget _pickerRow({required String texto, required IconData icon}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(color: const Color(0xFF1C1C3A), borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Expanded(child: Text(texto, style: const TextStyle(color: Colors.white70))),
      Icon(icon, color: Colors.cyanAccent),
    ]),
  );
}
