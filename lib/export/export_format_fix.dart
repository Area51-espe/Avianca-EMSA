import 'package:excel/excel.dart';

class ExportFormatFix {
  /// Aplica estilo a encabezados y datos + "padding visual" vía anchos/altos.
  static void styleSheet({
    required Sheet sheet,
    int headerRowIndex = 3,     // fila de encabezados
    int firstDataRowIndex = 4,  // primera fila con datos
    List<int>? colWidths,       // anchos sugeridos (en "caracteres" aprox.)
  }) {
    final maxCols = _maxUsedCols(sheet);
    final lastRow = sheet.rows.length - 1;

    // Estilo de encabezado (sin bg por compatibilidad de versión)
    final headerStyle = CellStyle(
      bold: true,
      fontSize: 11,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    for (var c = 0; c < maxCols; c++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: c, rowIndex: headerRowIndex),
      );
      cell.cellStyle = headerStyle;
    }

    // Estilo del cuerpo (sin wrap por compatibilidad de versión)
    final bodyStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Left,
      verticalAlign: VerticalAlign.Center,
      fontSize: 10,
    );
    for (var r = firstDataRowIndex; r <= lastRow; r++) {
      for (var c = 0; c < maxCols; c++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: c, rowIndex: r),
        );
        if (cell.value != null) {
          cell.cellStyle = bodyStyle;
        }
      }
    }

    // “Padding visual”: anchos de columnas + altura de filas
    final widths = colWidths ?? _suggested(maxCols);
    for (var c = 0; c < widths.length; c++) {
      sheet.setColumnWidth(c, widths[c].toDouble()); // compatible con v4
    }
    sheet.setRowHeight(headerRowIndex, 22);
    for (var r = firstDataRowIndex; r <= lastRow; r++) {
      sheet.setRowHeight(r, 18);
    }
  }

  static List<int> _suggested(int cols) {
    // Orden típico: Fecha, Hora, Destino, (luego otras)
    final base = <int>[12, 9, 22, 14, 14, 14, 14];
    return cols <= base.length
        ? base.sublist(0, cols)
        : [...base, ...List.filled(cols - base.length, 14)];
  }

  static int _maxUsedCols(Sheet sheet) {
    var m = 0;
    for (final r in sheet.rows) {
      if (r.length > m) m = r.length;
    }
    return m;
  }
}
