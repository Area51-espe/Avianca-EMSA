import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'export_format_fix.dart';

/// Demo mínima para EMSA-56: genera un Excel con columnas Fecha|Hora|Destino
/// y aplica formato (anchos, header bold, alineación) como evidencia.
Future<void> generarExcelDemoEmsa56() async {
  final excel = Excel.createExcel();
  final sheet = excel['Recorridos'];
  final df = DateFormat('dd/MM/yyyy');

  // Fila 0-2: título / nota / línea vacía
  sheet.appendRow([TextCellValue('Reporte demo EMSA-56 (formato/padding)')]);
  sheet.appendRow([TextCellValue('NOTA: datos de ejemplo para evidenciar estilos.')]);
  sheet.appendRow([TextCellValue('')]); // ← sin const

  // Encabezados (fila 3)
  sheet.appendRow([
    TextCellValue('Fecha'),
    TextCellValue('Hora'),
    TextCellValue('Destino'),
  ]);

  // Filas de datos (fila 4 en adelante)
  final rows = [
    {'fecha': DateTime(2025, 5, 1), 'hora': '08:30', 'destino': 'Quito'},
    {'fecha': DateTime(2025, 5, 1), 'hora': '13:45', 'destino': 'Latacunga'},
  ];

  for (final r in rows) {
    sheet.appendRow([
      TextCellValue(df.format(r['fecha'] as DateTime)),
      TextCellValue(r['hora'] as String),
      TextCellValue(r['destino'] as String),
    ]);
  }

  // APLICAR FORMATO EMSA-56
  ExportFormatFix.styleSheet(
    sheet: sheet,
    headerRowIndex: 3,     // aquí están los headers
    firstDataRowIndex: 4,  // aquí comienzan los datos
    colWidths: const [12, 9, 22], // Fecha, Hora, Destino
  );

  final bytes = excel.encode()!;
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/reporte_demo_emsa56.xlsx');
  await file.writeAsBytes(bytes, flush: true);
  await OpenFilex.open(file.path);
}
