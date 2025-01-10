
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/dashbord/menu.dart';
import '../../color/colors.dart';
import '../dashbord/logout.dart';
import 'ajoutecarte.dart';
class CardListPage extends StatefulWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  late Stream<QuerySnapshot> _cardsStream;

Future<void> _deleteCard(DocumentSnapshot cardDoc) async {
    try {
      await cardDoc.reference.delete();
    } catch (e) {
      print('Error deleting card: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    _cardsStream = FirebaseFirestore.instance
        .collection('cartes')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Center(child: Text("")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: logoGreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ajoutecartee(barcode: ''),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: logoGreen,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _cardsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> userCardsDocs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: userCardsDocs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot cardDoc = userCardsDocs[index];
              String name = cardDoc.get('name') ?? '';
              String photoUrl = cardDoc.get('photoUrl') ?? '';

              return GestureDetector(
                onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => screnn(cardId:cardDoc.id,name: name, ),
                    ),
                  );

                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromARGB(149, 236, 234, 234),
                    ),
                  child: Card(
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                
                      children: [
                        CircleAvatar(
                         
                          backgroundImage: AssetImage(photoUrl),
                           radius: 60.0,
                
                        ),
                        SizedBox(height: 10),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                       IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirmation"),
                                  content: Text("Are you sure you want to delete this card?"),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("DELETE"),
                                      onPressed: () async {
                                        await _deleteCard(cardDoc);
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
