import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class RegistroExcelPage extends StatefulWidget {
  const RegistroExcelPage({Key? key}) : super(key: key);

  @override
  State<RegistroExcelPage> createState() => _RegistroExcelPageState();
}

class _RegistroExcelPageState extends State<RegistroExcelPage> {
  List<Map<String, dynamic>> _registros = [];
  List<Map<String, dynamic>> _registrosFiltrados = [];
  DateTime? _fechaInicio;
  DateTime? _fechaFin;
  String? _tipoSeleccionado;

  @override
  void initState() {
    super.initState();
    _cargarDatosEstaticos();
  }

  void _cargarDatosEstaticos() {
    // Datos estáticos de ejemplo
    final datosEstaticos = [
      {
        'id': '1',
        'nombreCliente': 'Juan Pérez',
        'tipoRecorrido': 'Entrada',
        'fecha': DateTime(2024, 12, 15),
        'hora': '08:30',
        'destino': 'Aeropuerto Internacional',
        'pasajeros': 2,
        'equipaje': '2 maletas grandes',
      },
      {
        'id': '2',
        'nombreCliente': 'María González',
        'tipoRecorrido': 'Salida',
        'fecha': DateTime(2024, 12, 16),
        'hora': '14:15',
        'destino': 'Hotel Plaza Central',
        'pasajeros': 1,
        'equipaje': '1 maleta mediana',
      },
      {
        'id': '3',
        'nombreCliente': 'Carlos Rodríguez',
        'tipoRecorrido': 'Entrada',
        'fecha': DateTime(2024, 12, 17),
        'hora': '10:45',
        'destino': 'Terminal de Buses',
        'pasajeros': 3,
        'equipaje': '3 maletas + 2 mochilas',
      },
      {
        'id': '4',
        'nombreCliente': 'Ana López',
        'tipoRecorrido': 'Cancelada - Pagada',
        'fecha': DateTime(2024, 12, 18),
        'hora': '16:00',
        'destino': 'Centro Comercial',
        'pasajeros': 2,
        'equipaje': 'Solo equipaje de mano',
      },
      {
        'id': '5',
        'nombreCliente': 'Roberto Silva',
        'tipoRecorrido': 'Maletas',
        'fecha': DateTime(2024, 12, 19),
        'hora': '09:20',
        'destino': 'Estación de Tren',
        'pasajeros': 1,
        'equipaje': '4 maletas grandes',
      },
      {
        'id': '6',
        'nombreCliente': 'Elena Martínez',
        'tipoRecorrido': 'Salida',
        'fecha': DateTime(2024, 12, 20),
        'hora': '12:30',
        'destino': 'Puerto Marítimo',
        'pasajeros': 4,
        'equipaje': '2 maletas + equipaje deportivo',
      },
      {
        'id': '7',
        'nombreCliente': 'Diego Torres',
        'tipoRecorrido': 'Entrada',
        'fecha': DateTime(2024, 12, 21),
        'hora': '18:45',
        'destino': 'Aeropuerto Secundario',
        'pasajeros': 1,
        'equipaje': '1 maleta pequeña',
      },
      {
        'id': '8',
        'nombreCliente': 'Patricia Vega',
        'tipoRecorrido': 'Salida',
        'fecha': DateTime(2024, 12, 22),
        'hora': '07:15',
        'destino': 'Hospital Central',
        'pasajeros': 2,
        'equipaje': 'Sin equipaje',
      },
    ];

    setState(() {
      _registros = datosEstaticos;
      _registrosFiltrados = datosEstaticos;
    });
  }

  void _filtrar() {
    setState(() {
      _registrosFiltrados = _registros.where((registro) {
        final fecha = registro['fecha'] as DateTime;
        final cumpleFecha = (_fechaInicio == null ||
                fecha.isAfter(
                    _fechaInicio!.subtract(const Duration(days: 1)))) &&
            (_fechaFin == null ||
                fecha.isBefore(_fechaFin!.add(const Duration(days: 1))));
        final cumpleTipo = _tipoSeleccionado == null ||
            _tipoSeleccionado == registro['tipoRecorrido'];
        return cumpleFecha && cumpleTipo;
      }).toList();
    });
  }

  void _quitarFiltros() {
    setState(() {
      _fechaInicio = null;
      _fechaFin = null;
      _tipoSeleccionado = null;
      _registrosFiltrados = _registros;
    });
  }

  Future<void> _exportarExcel() async {
    try {
      final excel = Excel.createExcel();
      final sheet = excel['Registros'];

      // Agregar encabezados
      sheet.appendRow([
        'Cliente',
        'Tipo',
        'Fecha',
        'Hora',
        'Destino',
        'Pasajeros',
        'Equipaje',
      ]);

      // Agregar datos
      for (var r in _registrosFiltrados) {
        final fecha = r['fecha'] as DateTime;
        sheet.appendRow([
          r['nombreCliente'] ?? '',
          r['tipoRecorrido'] ?? '',
          DateFormat('dd/MM/yyyy').format(fecha),
          r['hora'] ?? '',
          r['destino'] ?? '',
          r['pasajeros'].toString(),
          r['equipaje'] ?? '',
        ]);
      }

      // Solicitar permisos
      final permiso = await Permission.manageExternalStorage.request();

      if (permiso.isGranted) {
        final dir = await getExternalStorageDirectory();
        final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        final path = '${dir!.path}/recorridos_$timestamp.xlsx';
        final file = File(path);

        await file.writeAsBytes(excel.encode()!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Archivo guardado: recorridos_$timestamp.xlsx'),
              backgroundColor: Colors.greenAccent,
              duration: Duration(seconds: 3),
            ),
          );

          // Abrir el archivo
          OpenFile.open(path);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permiso de almacenamiento denegado'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al exportar: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _editarRegistro(Map<String, dynamic> registro) {
    final nombreCtrl = TextEditingController(text: registro['nombreCliente']);
    final horaCtrl = TextEditingController(text: registro['hora']);
    final destinoCtrl = TextEditingController(text: registro['destino']);
    final pasajerosCtrl =
        TextEditingController(text: registro['pasajeros'].toString());
    final equipajeCtrl = TextEditingController(text: registro['equipaje']);
    String tipoRecorrido = registro['tipoRecorrido'];
    DateTime? nuevaFecha = registro['fecha'] as DateTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A40),
        title: const Text(
          'Editar Recorrido',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEditLabel('Cliente'),
              _buildEditField(nombreCtrl),
              _buildEditLabel('Hora'),
              _buildEditField(horaCtrl),
              _buildEditLabel('Destino'),
              _buildEditField(destinoCtrl),
              _buildEditLabel('Pasajeros'),
              _buildEditField(pasajerosCtrl),
              _buildEditLabel('Equipaje'),
              _buildEditField(equipajeCtrl),
              _buildEditLabel('Tipo Recorrido'),
              StatefulBuilder(
                builder: (context, setStateDialog) => DropdownButton<String>(
                  dropdownColor: const Color(0xFF2B2B50),
                  value: tipoRecorrido,
                  isExpanded: true,
                  items: ['Entrada', 'Salida', 'Cancelada - Pagada', 'Maletas']
                      .map((tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Text(
                              tipo,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setStateDialog(() => tipoRecorrido = value!),
                ),
              ),
              const SizedBox(height: 10),
              _buildEditLabel('Fecha'),
              ElevatedButton(
                onPressed: () async {
                  final fechaSeleccionada = await showDatePicker(
                    context: context,
                    initialDate: nuevaFecha ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                    builder: (context, child) => Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Colors.cyanAccent,
                          surface: Color(0xFF1A1A40),
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (fechaSeleccionada != null) {
                    nuevaFecha = fechaSeleccionada;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                ),
                child: const Text(
                  'Seleccionar Fecha',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    onPressed: () {
                      // Actualizar el registro en la lista
                      final index = _registros
                          .indexWhere((r) => r['id'] == registro['id']);
                      if (index != -1) {
                        setState(() {
                          _registros[index] = {
                            'id': registro['id'],
                            'nombreCliente': nombreCtrl.text,
                            'hora': horaCtrl.text,
                            'destino': destinoCtrl.text,
                            'pasajeros': int.tryParse(pasajerosCtrl.text) ?? 1,
                            'equipaje': equipajeCtrl.text,
                            'tipoRecorrido': tipoRecorrido,
                            'fecha': nuevaFecha!,
                          };
                        });
                        _filtrar();
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _eliminarRegistro(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A40),
        title: const Text(
          'Confirmar Eliminación',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro de que quieres eliminar este registro?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _registros.removeWhere((r) => r['id'] == id);
              });
              _filtrar();
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabla() {
    if (_registrosFiltrados.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No hay registros que coincidan con los filtros',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color(0xFF3B8AC4)),
            columns: const [
              DataColumn(
                label: Text('Cliente', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Tipo', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Fecha', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Hora', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Destino', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Pasajeros', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Equipaje', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Acciones', style: TextStyle(color: Colors.white)),
              ),
            ],
            rows: _registrosFiltrados.map((r) {
              final fecha = r['fecha'] as DateTime;
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      r['nombreCliente'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(
                      r['tipoRecorrido'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(
                      DateFormat('dd/MM/yyyy').format(fecha),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(r['hora'],
                        style: const TextStyle(color: Colors.white)),
                  ),
                  DataCell(
                    Text(
                      r['destino'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(
                      '${r['pasajeros']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(
                      r['equipaje'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.yellowAccent,
                          ),
                          onPressed: () => _editarRegistro(r),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _eliminarRegistro(r['id']),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildEditLabel(String label) => Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 4),
        child: Text(label, style: const TextStyle(color: Colors.white70)),
      );

  Widget _buildEditField(TextEditingController controller) => TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFF2B2B50),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.white54),
        ),
      );

  Widget _buildFiltros() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A40),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Filtros de Registros",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2B50),
                  ),
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                      builder: (context, child) => Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Colors.cyanAccent,
                            surface: Color(0xFF1A1A40),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (fecha != null) setState(() => _fechaInicio = fecha);
                  },
                  child: Text(
                    _fechaInicio != null
                        ? 'Desde: ${DateFormat('dd/MM/yyyy').format(_fechaInicio!)}'
                        : 'Fecha inicio',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2B50),
                  ),
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                      builder: (context, child) => Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Colors.cyanAccent,
                            surface: Color(0xFF1A1A40),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (fecha != null) setState(() => _fechaFin = fecha);
                  },
                  child: Text(
                    _fechaFin != null
                        ? 'Hasta: ${DateFormat('dd/MM/yyyy').format(_fechaFin!)}'
                        : 'Fecha fin',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _tipoSeleccionado,
            dropdownColor: const Color(0xFF2B2B50),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFF2B2B50),
              hintText: 'Filtrar por tipo',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.white,
            items: ['Entrada', 'Salida', 'Cancelada - Pagada', 'Maletas']
                .map(
                  (tipo) => DropdownMenuItem(
                    value: tipo,
                    child: Text(
                      tipo,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _tipoSeleccionado = value),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                ),
                onPressed: _filtrar,
                icon: const Icon(Icons.filter_alt, color: Colors.black),
                label: const Text(
                  'Aplicar Filtros',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: _quitarFiltros,
                child: const Text(
                  'Quitar Filtros',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A40),
        title: Text(
          'Registros Excel (${_registrosFiltrados.length} registros)',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download_for_offline,
              color: Colors.cyanAccent,
            ),
            onPressed: _registrosFiltrados.isNotEmpty ? _exportarExcel : null,
            tooltip: 'Exportar a Excel',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFiltros(),
            const SizedBox(height: 16),
            _buildTabla(),
          ],
        ),
      ),
    );
  }
}
