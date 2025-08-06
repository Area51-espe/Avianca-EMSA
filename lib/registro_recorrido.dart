import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroRecorridoScreen extends StatefulWidget {
  const RegistroRecorridoScreen({super.key});

  @override
  State<RegistroRecorridoScreen> createState() => _RegistroRecorridoScreenState();
}

class _RegistroRecorridoScreenState extends State<RegistroRecorridoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? tipoRecorrido;
  DateTime? fecha;
  TimeOfDay? hora;
  String? destino;
  int? pasajeros;
  bool? llevaEquipaje;
  final TextEditingController nombreClienteController = TextEditingController();

  final List<String> tipos = ['Entrada', 'Salida', 'Cancelada - Pagada', 'Maletas'];
  final List<String> destinos = ['Quito', 'Guayaquil', 'Cuenca', 'Latacunga'];

  void seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fecha ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData.dark(),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => fecha = picked);
    }
  }

  void seleccionarHora() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: hora ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark(),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => hora = picked);
    }
  }

  void mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void guardarRecorrido() {
    if (_formKey.currentState!.validate()) {
      if (tipoRecorrido == null) {
        mostrarError('Debe seleccionar el tipo de recorrido');
        return;
      }
      if (fecha == null) {
        mostrarError('Debe seleccionar una fecha');
        return;
      }
      if (hora == null) {
        mostrarError('Debe seleccionar una hora');
        return;
      }
      if (destino == null) {
        mostrarError('Debe seleccionar un destino');
        return;
      }
      if (pasajeros == null) {
        mostrarError('Debe seleccionar el número de pasajeros');
        return;
      }
      if (llevaEquipaje == null) {
        mostrarError('Debe indicar si lleva equipaje');
        return;
      }

      // Si pasa todas las validaciones
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recorrido guardado correctamente")),
      );

      // Aquí puedes guardar o enviar los datos a una API
    }
  }

  Widget buildToggleGroup<T>({
    required List<T> items,
    required T? selected,
    required void Function(T) onSelected,
    required String Function(T) labelBuilder,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((item) {
        final bool isSelected = item == selected;
        return GestureDetector(
          onTap: () => onSelected(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.cyanAccent : const Color(0xFF3C3C3C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              labelBuilder(item),
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) labelBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C3A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<T>(
            dropdownColor: const Color(0xFF1C1C3A),
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(labelBuilder(item), style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(border: InputBorder.none),
            iconEnabledColor: Colors.cyanAccent,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A23),
        title: const Text("Registro de Recorrido", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tipo de Recorrido", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              buildToggleGroup<String>(
                items: tipos,
                selected: tipoRecorrido,
                onSelected: (val) => setState(() => tipoRecorrido = val),
                labelBuilder: (val) => val,
              ),
              const SizedBox(height: 20),
              const Text("Fecha", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: seleccionarFecha,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C3A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          fecha != null
                              ? DateFormat('dd/MM/yyyy').format(fecha!)
                              : 'Seleccione una fecha',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.cyanAccent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Hora", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: seleccionarHora,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C3A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          hora != null
                              ? hora!.format(context)
                              : 'Seleccione una hora',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      const Icon(Icons.access_time, color: Colors.cyanAccent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildDropdown<String>(
                label: "Destino",
                value: destino,
                items: destinos,
                onChanged: (val) => setState(() => destino = val),
                labelBuilder: (val) => val,
              ),
              const SizedBox(height: 20),
              const Text("Número de Pasajeros", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              buildToggleGroup<int>(
                items: [1, 2, 3, 4],
                selected: pasajeros,
                onSelected: (val) => setState(() => pasajeros = val),
                labelBuilder: (val) => val.toString(),
              ),
              const SizedBox(height: 20),
              const Text("¿Lleva equipaje?", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              buildToggleGroup<bool>(
                items: [true, false],
                selected: llevaEquipaje,
                onSelected: (val) => setState(() => llevaEquipaje = val),
                labelBuilder: (val) => val ? "Sí" : "No",
              ),
              const SizedBox(height: 20),
              const Text("Datos del Cliente", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              TextFormField(
                controller: nombreClienteController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre del cliente es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Nombre del cliente',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1C3A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: guardarRecorrido,
                  icon: const Icon(Icons.save, color: Colors.black),
                  label: const Text("GUARDAR RECORRIDO"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
