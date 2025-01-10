import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import '../../color/colors.dart';
import '../../firebase_options.dart';
import '../historique.dart/historique.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../pagedegarde/login.dart';

Future<void> fo() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
   
}


class screnn extends StatefulWidget {
  final String cardId;
  String name;

   screnn({ required this.cardId,required this.name}) ;

  @override
  State<screnn> createState() => _scrennState();
}

class _scrennState extends State<screnn> {

 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


void initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon'); // Remplacez 'app_icon' par le nom de votre icône d'application

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> _showNotification(String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id', // Remplacez 'channel_id' par un identifiant unique pour votre canal de notification
    'channel_name', // Remplacez 'channel_name' par le nom de votre canal de notification
  // Remplacez 'channel_description' par la description de votre canal de notification
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // ID de la notification
    'Mouvement détecté', // Titre de la notification
    message, // Corps de la notification
    platformChannelSpecifics,
  );
}


      bool _isDetected = false;
     //est une liste de chaînes qui stocke l'historique des messages affichés à l'utilisateur.
     List<String> messageHistory = [];
     //variable pour suivre les messages à déplacer vers la page "Historique"
     List<String> messagesToMove = [];


    //Cette fonction affiche un toast avec un message spécifié.
      void _showToast(String message) {
        String timestamp = DateTime.now().toString();
        String toastMessage = '$message - $timestamp';
        Fluttertoast.showToast(
          msg: toastMessage,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 7,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0,
          
        );
        
        Future.delayed(Duration.zero, () {
        updateMessageHistory(toastMessage);
        _saveMessageHistory();
      });
   _sendNotification(message)  ;   
      }


      // Method to send a push notification to the user's device

    //Cette fonction ajoute un message à l'historique des messages
  void updateMessageHistory(String message) {
    setState(() {
      messageHistory.add(message);
      if (messageHistory.length > 5) {
        messagesToMove.insert(0, messageHistory[0]);
        messageHistory.removeAt(0);
      }
    });
  }




 // Ajoutez cette méthode pour envoyer une notification push
  Future<void> _sendNotification(String message) async {
    await FirebaseFirestore.instance.collection('historique').add({
      'message': message,
      'cardId': widget.cardId,
      'timestamp': DateTime.now(),
      'name':widget.name
    });
     if (widget.cardId == widget.cardId) {
  }
  }


  //sauvegarder l'historique des messages dans les SharedPreferences
Future<void> _saveMessageHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (messageHistory.isNotEmpty) {
    await prefs.setStringList('messageHistory', messageHistory.reversed.toList());
  }
  await prefs.setStringList('messagesToMove', messagesToMove);
}

      Future<void> _loadMessageHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? history = prefs.getStringList('messageHistory');
  List<String>? movedMessages = prefs.getStringList('messagesToMove');
  if (history != null) {
    setState(() {
      messageHistory = history.reversed.toList();
    });
  }
  if (movedMessages != null) {
    setState(() {
      messagesToMove = movedMessages;
    });
  }
}
// pour charger l'historique des messages au démarrage de l'application
@override
void initState() {
  super.initState();
  _loadMessageHistory();
    initializeNotifications();


}




  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final User? user = FirebaseAuth.instance.currentUser;

 
 Widget buildHeader(BuildContext context)=> UserAccountsDrawerHeader(

    decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color.fromRGBO(222, 232, 247, 1),
              Color.fromRGBO(220, 234, 246, 1),
              Color.fromRGBO(13, 71, 161, 1),
              Color.fromRGBO(144, 202, 249, 1)
            ],
          ),
        ),  
     accountName: Text("Connecté en tant que :",
       style: TextStyle(
            fontSize: 25,
            color: Colors.white,
           decorationStyle: TextDecorationStyle.wavy,

          ),
     
     ),  
      accountEmail:Text(' ${user?.email != null ? user!.email!.split('@')[0] : "Unknown"}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
           decorationStyle: TextDecorationStyle.wavy,

          ),
          
          ),
     currentAccountPicture: CircleAvatar(  
                backgroundColor:Colors.white,  
                child: Icon(Icons.person,
                size: 50,) 
              ),  
            );
  

  
  Widget builMenuItems(BuildContext context) => Column(
    children: [
      ListTile(
        leading:const Icon(Icons.home_outlined),
        title: const Text('Dashbord'),
      ),
     
         ListTile(
        leading:const Icon(Icons.history_edu_outlined),
        title: const Text('historique'),
       onTap: (){
           Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>
       HistoriquePage(messagesToMove: messagesToMove),
         ));

        },
         ),

             ListTile(
        leading:const Icon(Icons.history_edu_outlined),
        title: const Text('Se déconnecter'),
       onTap: (){
          FirebaseAuth.instance.signOut();
     Navigator.of(context).pushReplacement(
                      
     MaterialPageRoute(builder: ((context) => LoginPage())));
        },
         )
        
      
      
    ],
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor:Color.fromRGBO(222, 232, 247, 1),

    ),
    drawer: Drawer(
    child: ListView(
      children: [
       buildHeader(context),
        builMenuItems(context),
      ],
    ),
    ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color.fromRGBO(222, 232, 247, 1),
              Color.fromRGBO(220, 234, 246, 1),
              Color.fromRGBO(13, 71, 161, 1),
              Color.fromRGBO(144, 202, 249, 1)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                     
                      
                      
                      ),
                    ),
                    
                    ClipOval(
                      child: Image.asset(
                        'assets/images/Business.png',
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
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
                            if (isDetected != _isDetected) {
                          _isDetected = isDetected;
                          String message = _isDetected ? 'Mouvement détecté' : 'Pas de détection';
                          _showToast(message);
                        }


                    return Column(
                      children: [
                        Text(
                          'Historique des messages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                                                  ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: messageHistory.length,
                              itemBuilder: (context, index) {
                                int reversedIndex = messageHistory.length - 1 - index;
                                if (reversedIndex >= 0 && reversedIndex < messageHistory.length) {
                                  String message = messageHistory[reversedIndex];
                                  int separatorIndex = message.lastIndexOf(" - ");
                                  if (separatorIndex != -1 && separatorIndex < message.length - 3) {
                                    String text = message.substring(0, separatorIndex);
                                    String timestamp = message.substring(separatorIndex + 3);
                                    return Dismissible(
                                      key: Key(message),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: Colors.red,
                                        child: Icon(Icons.delete),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      onDismissed: (direction) {
                                        setState(() {
                                          // Supprimez l'élément de l'historique correspondant au message supprimé
                                          messageHistory.removeAt(reversedIndex);
                                        });
                                      },
                                      child: ListTile(
                                        title: Text(text),
                                        subtitle: Text(timestamp),
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      title: Text('Format de message incorrect'),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                  ],
                );



                          },
                ),
              ),
            )




          ],
        ),
      ),
    );}
    
    
    
    
    
    }
