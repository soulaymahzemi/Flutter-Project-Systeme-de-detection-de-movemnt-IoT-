
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/page/Esppage/affichagecard.dart';
import 'package:flutter_application_1/page/pagedegarde/header.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../color/colors.dart';
import '../../firebase_options.dart';
import '../dashbord/dashbord.dart';
import 'header3.dart';
class adduserpage extends StatefulWidget {
  String barcode;
  adduserpage({required this.barcode});

  @override
  State<adduserpage> createState() => _adduserpageeState(barcode: this.barcode);
}

 final _emailadmin=TextEditingController();
     final _passworddadmin=TextEditingController();
     final _nameadmin=TextEditingController();
         final formkey=GlobalKey <FormState>();
     bool _ispasswordvisible=false;
     bool _ispasswordcharacters=false;
     bool _ispasswordonnumber=false;
    final defaultImageUrl = AssetImage("assets/images/esp32.jpg").assetName;
   //////// Signgup ///////

  void _Register(String barcode, String password,String email,String name)async{
  
  String email= _emailadmin.text.trim();
  String password=_passworddadmin.text.trim();
  String name=_nameadmin.text.trim();
  String photoUrl = defaultImageUrl;

  try{
    // Create user account in Firebase Authentication
 UserCredential userCredential  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    
    // Save user data in Firestore
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc();
    userDoc.set({
      "email": email,
      "password":password,
      "userId": userCredential.user?.uid,
    
    });
   
    // Save card data in Firestore
    DocumentReference cardDoc = FirebaseFirestore.instance.collection('cartes').doc();
    String cardId = cardDoc.id;
    cardDoc.set({
      "barcode":barcode,
      "name":name,
      "photoUrl": photoUrl ,
      "cardId":cardId,
      "userId": userCredential.user?.uid,
    });

      DocumentReference detectionDoc = FirebaseFirestore.instance.collection('detection').doc(); 
    String detId=detectionDoc.id;
    detectionDoc.set({
       "detId":detId,
       "cardId":cardId,
       'isDetected':true,
       "datetime": FieldValue.serverTimestamp()
       },SetOptions(merge: true));
  } on FirebaseAuthException catch(e){
    print(e);
  }
}

    class _adduserpageeState extends State <adduserpage>{
      String barcode;
      _adduserpageeState({required this.barcode});  
     onchangedpassword(String password) {
        final numericRegex = RegExp(r'[0-7]');
     setState(() {
      _ispasswordcharacters=false;
      if(password.length>=6)
      {
        _ispasswordcharacters=true;
      }
      _ispasswordonnumber=false;
      if(numericRegex.hasMatch(password)){
        _ispasswordonnumber=true;
      }
     });
     }
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          color:  Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderContainer3(),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formkey,

                  child: 
                Column(
                  children: [
                    Container(
                      child: 
                       TextFormField(
                      validator: (value) {
                            if(value==null||value.isEmpty){
                              return "veuillez entrer le nom ";
                            }
                            return null;
                          },                       
                           controller: _nameadmin,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Nom de la carte',
                           contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                        ),
                        

                      ),
                    )
                    ,
                    SizedBox(height: 10,),
                    Container(
                      child: TextFormField(
                      validator: (value) {
                            if(value==null||value.isEmpty){
                              return "please enter email ";
                            }
                            return null;
                          },                      
                            controller: _emailadmin,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Adresse e-mail ',
                           contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                        ),
                        

                      ),
                      
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child:  TextFormField(
                          controller: _passworddadmin,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return "please enter password";
                            }
                            return null;
                          },
                          onChanged:(password) => onchangedpassword(password),
                          obscureText: !_ispasswordvisible ,
                          decoration:InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _ispasswordvisible=!_ispasswordvisible;
                                });
                              },
                              icon: _ispasswordvisible  ? Icon(Icons.visibility,color: Colors.black,):Icon(Icons.visibility_off,color: Colors.grey,)
                              ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                            borderSide:BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                            hintText: "Mot de passe",
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              
                          ),
                        ),
                    ),
                     SizedBox(height: 20,),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                             color: _ispasswordcharacters? Colors.green:Colors.transparent,
              
                              border:_ispasswordcharacters? Border.all(color: Colors.transparent) :Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(50),
              
                            ),
                            child: Center(child: Icon(Icons.check,color: Colors.white,size: 15,),),
                            ),
                            SizedBox(width: 10,),
                            Text("Contient au moins 6 caractères")
                        ],
                      ),
                      SizedBox(height: 10,),
                         Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                             color: _ispasswordonnumber? Colors.green:Colors.transparent,
              
                              border: _ispasswordonnumber? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(50),
              
                            ),
                            child: Center(child: Icon(Icons.check,color: Colors.white,size: 15,),),
                            ),
                            SizedBox(width: 10,),
                            Text("Contient au moins 1 numéro")
                        ],
                      ),
                  ],
                )
                ),
              ),
                  SizedBox(height: 20,),
                   MaterialButton(
  onPressed: () async {
    if (formkey.currentState!.validate()) {
      if (_passworddadmin.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Le mot de passe doit comporter au moins 6 caractères")),
        );
      } else {
        _Register(barcode, _emailadmin.text, _passworddadmin.text, _nameadmin.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("L'utilisateur a été enregistré avec succès !")),
        );
     // Navigator.push(context, MaterialPageRoute(builder: (context) =>Affichage(password: '',) ));
      }
    }
  },
  height: 40,
  minWidth: 20,
  color:  Color.fromRGBO(144, 202, 249, 1),
  child: Text("Se Connecter", style: TextStyle(color: Colors.white)),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
),


            ],
          ),
        ),
      ),
    );
  }
}