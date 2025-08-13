import 'package:flutter/material.dart';

class ExportTemplate {
  final DateTimeRange range;
  final String destination;
  final TimeOfDay? time; // opcional

  ExportTemplate({required this.range, required this.destination, this.time});

  String get time24 => time == null
      ? ''
      : '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}';

  Map<String, dynamic> toJson() => {
        'from': range.start.toIso8601String(),
        'to': range.end.toIso8601String(),
        'destination': destination,
        'time': time24.isEmpty ? null : time24,
      };

  static ExportTemplate fromJson(Map<String, dynamic> j) => ExportTemplate(
        range: DateTimeRange(
          start: DateTime.parse(j['from'] as String),
          end: DateTime.parse(j['to'] as String),
        ),
        destination: j['destination'] as String,
        time: j['time'] == null
            ? null
            : () {
                final p = (j['time'] as String).split(':');
                return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
              }(),
      );
}
