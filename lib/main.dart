import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Esppage/affichagecard.dart';
import 'package:flutter_application_1/page/Esppage/l.dart';
import 'package:flutter_application_1/page/dashbord/dashbord.dart';
import 'package:flutter_application_1/page/dashbord/menu.dart';
import 'package:flutter_application_1/page/dashbord/texte.dart';
import 'package:flutter_application_1/page/pagedegarde/pagedegarde.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetStartpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
