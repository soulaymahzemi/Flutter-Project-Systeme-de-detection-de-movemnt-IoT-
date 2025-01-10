import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/page/Esppage/scannecarte.dart';

import '../buttonstyle/button.dart';
import '../scannerpage.dart';

class ajoutecartee extends StatefulWidget {
String barcode;
ajoutecartee({required this.barcode});

  @override
  State<ajoutecartee> createState() => _MyWidgetState(barcode: this.barcode);
}

class _MyWidgetState extends State<ajoutecartee> {
  String barcode;
  _MyWidgetState ({required this.barcode,});
 final  nameadd=TextEditingController()  ;
  final formkey=GlobalKey <FormState>();

final defaultImageUrl = AssetImage("assets/images/esp32.jpg").assetName;





void carteadd(String barcode)async {
  String name = nameadd.text.trim();
  String photoUrl = defaultImageUrl;

    // Ajouter la carte dans la collection "cartes" avec le mot de passe de l'utilisateur
    DocumentReference<Map<String, dynamic>> newcartes =
     FirebaseFirestore.instance.collection('cartes').doc();
      String newCardDoc=newcartes.id;   
       newcartes.set({
      "userId":FirebaseAuth.instance.currentUser?.uid.toString(),
      "barcode": barcode,
      "name": name,
      "photoUrl": photoUrl,
       "cardId":newCardDoc

    });
   DocumentReference detectionDoc = FirebaseFirestore.instance.collection('detection').doc(); 
    String detId=detectionDoc.id;
    detectionDoc.set({
      "detId":detId,
       'isDetected':true,
        "cardId":newCardDoc,
       "datetime": FieldValue.serverTimestamp()

       
  
    },SetOptions(merge: true));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logoGreen,
         leading: IconButton(
      onPressed: (){
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => UserCardsPage()));
      },
      icon:Icon(Icons.arrow_back_ios), 
      //replace with our own icon data.
  )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Padding(
            
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Ajouter une autre carte',
            textAlign:TextAlign.center,
            style:TextStyle(
              fontSize: 20,
            ),),
          ),
          SizedBox(height: 20,),
         Padding(padding: EdgeInsets.symmetric(horizontal: 25),
           child: Column(
            children:<Widget> [
               _buttonscanne(),
               SizedBox(height: 10,),
               Text('créer dans le champ nom le nom de lemplacement de la carte'),
               Form(
              key: formkey,

                 child: Container(
                  
                  child:   TextFormField(
                        validator: (value) {
                              if(value==null||value.isEmpty){
                                return "veuillez entrer le nom ";
                              }
                              return null;
                            },                       
                             controller: nameadd,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black),),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'nom de la carte',
                             contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
               
                          ),
                          
               
                        ),
                 ),
               ),SizedBox(height: 15,),
               Center(
                        
                        child: _button()
                          
                      ),
            ],
           ),
       ) ],
      ),
    );
  }
  
   Widget _button(  ){

    return 
    InkWell(
          child:ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              
              minimumSize: Size(200, 40),
              backgroundColor: logoGreen ,
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(
               Radius.circular(50),
               
                )
                
              )
              ,

            ),
             
  
                onPressed:() async{
                

                 carteadd(barcode);
                  nameadd.text="";     


            } 
        ,
        child:  Text(
            "Confirmer",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),)
        );
    
    
  }
  _buttonscanne() {
      return 
        ElevatedButton.icon(
        style: buttonStyle,
        onPressed: (){
          Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:
                     (context )=> Scannecarte() ,
      
                   
                    )); 
        },
        icon: Icon(Icons.qr_code,color: Colors.grey,),
         label: Text("AJOUTER un nouvel ESP ",style: TextStyle(
          color: Colors.grey,
          
         ),));
  }
}
