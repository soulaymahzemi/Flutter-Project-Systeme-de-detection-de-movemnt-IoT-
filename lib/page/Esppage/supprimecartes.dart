  import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _deleteCard(DocumentSnapshot cardDoc) async {
    try {
      await cardDoc.reference.delete();
    } catch (e) {
      print('Error deleting card: $e');
    }
  }