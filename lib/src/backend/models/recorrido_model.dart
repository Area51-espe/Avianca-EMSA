import 'package:cloud_firestore/cloud_firestore.dart';

class Recorrido {
  final String id;
  final String tipo;
  final DateTime fecha;
  final String hora;
  final String destino;
  final int pasajeros;
  final bool equipaje;
  final String? clienteNombre;
  final bool maletas;

  Recorrido({
    this.id = '',
    required this.tipo,
    required this.fecha,
    required this.hora,
    required this.destino,
    required this.pasajeros,
    required this.equipaje,
    this.clienteNombre,
    required this.maletas,
  });

  factory Recorrido.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Recorrido(
      id: doc.id,
      tipo: data['tipo'],
      fecha: (data['fecha'] as Timestamp).toDate(),
      hora: data['hora'] ?? '',
      destino: data['destino'],
      pasajeros: data['pasajeros'],
      equipaje: data['equipaje'],
      clienteNombre: data['clienteNombre'],
      maletas: data['maletas'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'fecha': fecha,
      'hora': hora,
      'destino': destino,
      'pasajeros': pasajeros,
      'equipaje': equipaje,
      if (clienteNombre != null) 'clienteNombre': clienteNombre,
      'maletas': maletas,
    };
  }
}
