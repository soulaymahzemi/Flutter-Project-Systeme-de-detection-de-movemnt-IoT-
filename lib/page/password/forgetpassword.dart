import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
 import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/page/password/header2.dart';

import '../../firebase_options.dart';
Future<void> forget() async {
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
}


      class ForgotPassword extends StatefulWidget{
         @override
     _forgetPassword createState() =>_forgetPassword();
     
       }
       class _forgetPassword extends State<ForgotPassword>{
        final formkey=GlobalKey <FormState>();
        final emailController=TextEditingController();
        
        
        @override
        void dispose(){
          emailController.dispose();
          super.dispose();
        }
        Future passwordrest ()async{
           try{
              await FirebaseAuth.instance.sendPasswordResetEmail(
                email: emailController.text.trim());
                showDialog(
                  context: context,
                 builder: (context){
                  return AlertDialog(
                    content: Text("Envoyer le lien de réinitialisation du mot de passe !, vérifiez votre e-mail"),
                  );
                 }
                 );
          }on FirebaseAuthException catch(e){
            print(e);

          }
        }
          @override
          Widget build(BuildContext context) {
           return Scaffold(
         body:
          SingleChildScrollView(
            child: Container(
          
              child: Column(
          
               children: [
                HeaderContainer2(),
             SizedBox(height: 70,),
              Container(
          
                child: Padding(
                  
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              
                  child: Text('entrez ladresse e-mail associée à votre compte',
                  textAlign:TextAlign.center,
                  style:TextStyle(
                    fontSize: 20,
                  ),),
                ),
              ),
              SizedBox(height: 30,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 25),
              child: 
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color:Colors.black )
                  ),
                  hintText: 'Email',
                  filled: true
                ),
              ),
              
              
              ),
              SizedBox(height: 10,),
              MaterialButton(
                     onPressed: () {
               passwordrest();
                     },
                     child: Text("Envoyer",
                     style: TextStyle(
              color: Colors.white,
              fontSize: 20,
                     ),
                     ),
                     color: Color.fromRGBO(144, 202, 249, 1)
            ,
               height:50 ,  
              minWidth: 20,     
               shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              )
                    ],
                  ),
            ),
          ),
    );
          
          } 
       
         Future VerifEmail()  async{
          showDialog(context: context
          , barrierDismissible: false,
          builder: (context)=>Center(
            child: CircularProgressIndicator(),
          ),
          );
          try{
            await FirebaseAuth.instance.
            sendPasswordResetEmail(email: emailController.text.trim());
            print('object');
            final _snackBar = SnackBar(
              backgroundColor:logoGreen,
             content: Text('mot de passe envoyer ,vérifier votre e-mail')
           );
          Navigator.of(context).popUntil((route) => route.isFirst);
          }on FirebaseAuthException catch(e){
            print(e);
            Navigator.of(context).pop();
          }
     
          
         }
       }
       
     