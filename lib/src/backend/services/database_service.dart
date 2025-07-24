import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recorrido_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveRecorrido(Recorrido recorrido) async {
    await _firestore.collection('recorridos').add(recorrido.toMap());
  }

  Stream<List<Recorrido>> getRecorridos(String userId) {
    return _firestore
        .collection('recorridos')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Recorrido.fromFirestore(doc)).toList());
  }
}
