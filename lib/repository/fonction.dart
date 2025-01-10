  import 'package:cloud_firestore/cloud_firestore.dart';

ajouteqrcode(String barcode ,String password ) async
    {
      
      var  qr=FirebaseFirestore.
      instance.collection("user")
      .doc();
    
         qr.set(
          {
          'barcode':barcode,
          'password':password,
         } 
         ).then((value) =>   
        
         print('**'),
        
         );
    }

    