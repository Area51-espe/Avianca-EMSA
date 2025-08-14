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
    if (picked != null) setState(() => fecha = picked);
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
    if (picked != null) setState(() => hora = picked);
  }

  Widget buildToggleFormField<T>({
    required List<T> items,
    required T? selected,
    required void Function(T) onSelected,
    required String Function(T) labelBuilder,
    required String errorText,
  }) {
    return FormField<T>(
      validator: (value) => value == null ? errorText : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: items.map((item) {
                final bool isSelected = item == selected;
                return GestureDetector(
                  onTap: () {
                    onSelected(item);
                    state.didChange(item);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.cyanAccent : const Color(0xFF3C3C3C),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
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
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildDropdownFormField<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) labelBuilder,
    required String errorText,
  }) {
    return FormField<T>(
      validator: (val) => val == null ? errorText : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C3A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: state.hasError ? Colors.redAccent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: DropdownButtonFormField<T>(
                value: value,
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(labelBuilder(item), style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (val) {
                  onChanged(val);
                  state.didChange(val);
                },
                decoration: const InputDecoration(border: InputBorder.none),
                dropdownColor: const Color(0xFF1C1C3A),
                iconEnabledColor: Colors.cyanAccent,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ),
          ],
        );
      },
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
              buildToggleFormField<String>(
                items: tipos,
                selected: tipoRecorrido,
                onSelected: (val) => setState(() => tipoRecorrido = val),
                labelBuilder: (val) => val,
                errorText: "Debe seleccionar un tipo de recorrido",
              ),
              const SizedBox(height: 20),
              const Text("Fecha", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              FormField<DateTime>(
                validator: (_) => fecha == null ? "Debe seleccionar una fecha" : null,
                builder: (state) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: seleccionarFecha,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C3A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: state.hasError ? Colors.redAccent : Colors.transparent,
                              width: 2,
                            ),
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
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text("Hora", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              FormField<TimeOfDay>(
                validator: (_) => hora == null ? "Debe seleccionar una hora" : null,
                builder: (state) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: seleccionarHora,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C3A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: state.hasError ? Colors.redAccent : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  hora != null ? hora!.format(context) : 'Seleccione una hora',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                              const Icon(Icons.access_time, color: Colors.cyanAccent),
                            ],
                          ),
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              buildDropdownFormField<String>(
                label: "Destino",
                value: destino,
                items: destinos,
                onChanged: (val) => setState(() => destino = val),
                labelBuilder: (val) => val,
                errorText: "Debe seleccionar un destino",
              ),
              const SizedBox(height: 20),
              const Text("Número de Pasajeros", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              buildToggleFormField<int>(
                items: [1, 2, 3, 4],
                selected: pasajeros,
                onSelected: (val) => setState(() => pasajeros = val),
                labelBuilder: (val) => val.toString(),
                errorText: "Debe seleccionar el número de pasajeros",
              ),
              const SizedBox(height: 20),
              const Text("¿Lleva equipaje?", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              buildToggleFormField<bool>(
                items: [true, false],
                selected: llevaEquipaje,
                onSelected: (val) => setState(() => llevaEquipaje = val),
                labelBuilder: (val) => val ? "Sí" : "No",
                errorText: "Debe indicar si lleva equipaje",
              ),
              const SizedBox(height: 20),
              const Text("Datos del Cliente", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              TextFormField(
                controller: nombreClienteController,
                style: const TextStyle(color: Colors.white),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'El nombre del cliente es obligatorio'
                    : null,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recorrido guardado correctamente")),
                      );
                    }
                  },
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
