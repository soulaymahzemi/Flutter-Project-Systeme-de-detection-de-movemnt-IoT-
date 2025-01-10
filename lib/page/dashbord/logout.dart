
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatefulWidget {
  final String cardId;

  const CardDetailPage({Key? key, required this.cardId}) : super(key: key);

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('detection')
                  .where('cardId', isEqualTo: widget.cardId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Text('No data found');
                }
                var doc = snapshot.data!.docs.first;
                var isDetected = doc['isDetected'] ?? false;
                return Text('Is Detected: $isDetected');
              },
            ),
          ],
        ),
      ),
    );
  }
}
