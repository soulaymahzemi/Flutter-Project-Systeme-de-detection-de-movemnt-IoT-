import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DetectionPage extends StatefulWidget {
  const DetectionPage({Key? key}) : super(key: key);

  @override
  _DetectionPageState createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  String _selectedCardId = ''; // ID de la carte sélectionnée

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('detection').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final documents = snapshot.data!.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            final cardId = document.id; // ID de la carte actuelle
            final isDetected = document['isDetected'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCardId = cardId;
                });
                Timer(Duration(seconds: 2), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Detection: ${isDetected ? 'Movement detected!' : 'No detection'}'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                });
              },
              child: SizedBox(
                width: double.infinity,
                height: 80.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: _selectedCardId == cardId
                        ? Colors.blue[100]
                        : Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 209, 208, 206),
                    ),
                    child: Text(
                      isDetected ? 'Movement detected!' : 'No detection',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
