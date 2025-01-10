import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/page/Esppage/affichagecard.dart';
import 'package:flutter_application_1/page/dashbord/dashbord.dart';
import 'package:flutter_application_1/page/password/forgetpassword.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../buttonstyle/button.dart';
import '../scannerpage.dart';
import 'header.dart';
import 'package:flutter_application_1/page/Esppage/ajoutecarte.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController controllerpassword=TextEditingController()  ;
  final TextEditingController controlleremail=TextEditingController()  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _buttonscanne(),
                       _textInput2(hint: "email", icon: Icons.email),
                      SizedBox(height: 10,),
              
                      _textInput(hint: "Password", icon: Icons.vpn_key),
              
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: 
                        GestureDetector(
                          child: Text(
                            "Mot de passe oublié?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 71, 71, 71),
                              fontSize: 15
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) =>ForgotPassword()));
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                         Center(
                          
                          child: _button()
                            
                        ),
                    
                      
                   
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _button(  ){

    return 
    InkWell(
          child:ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              
              minimumSize: Size(200, 40),
              backgroundColor:                 Color.fromRGBO(144, 202, 249, 1)
,
 
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(
               Radius.circular(50),
               
                )
                
              )
              ,
            ),
            onPressed:(){
              _signIn();
            } 

        ,
        child:  Text(
            "Confirm",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),)
        );
    
    
  }
  void _signIn2()async{
          try{

            await FirebaseAuth.instance.signInWithEmailAndPassword(email: controlleremail.text, password: controllerpassword.text);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>  CardListPage() ));

          } on FirebaseAuthException catch(e)
          {
            print("error");
        
          }
          
        } 
void _signIn() async {
  try {
    // Verify that email and password fields are not empty
    if (controlleremail.text.isEmpty || controllerpassword.text.isEmpty) {
      throw FirebaseAuthException(
          code: 'invalid-input', message: 'Email or password is empty');
    }

    // Sign in with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: controlleremail.text,
      password: controllerpassword.text,
    );

    // Verify that the user has a password set
    if (userCredential.user == null ||
        userCredential.user!.providerData
            .any((provider) => provider.providerId == "password") == false) {
      throw FirebaseAuthException(
          code: 'invalid-user',
          message: 'User does not have a password set or does not exist');
    }

    // Navigate to the card list page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CardListPage()));
  } on FirebaseAuthException catch (e) {
    // Show an error message if sign-in fails
    print(e.toString());
  }
}

  Widget _buttonscanne(){
    return 
        ElevatedButton.icon(
        style: buttonStyle,
        onPressed: (){
          Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:
                     (context )=> QRscanner() ,
      
                   
                    )); 
        },
        icon: Icon(Icons.qr_code,color: Colors.grey,),
         label: Text("AJOUTER  ESP ",style: TextStyle(
          color: Colors.grey,
          
         ),));

  
  }
 
Future<void> searchpassword2() async {
  var result = await FirebaseFirestore.instance
      .collection('users')
      .where('password', isEqualTo: controllerpassword.text)
      .where('email',isEqualTo: controlleremail.text)
      .get();
  
  if (result.docs.isNotEmpty) {
    print(" exists");
 
  } else {
    print("password or email does not exist");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 136, 128),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Oops!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const Text(
                 'the email or password is incorrect! please try again..',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _textInput({ hint, icon}) {
    bool _ispassword=false;
    var _isobscured;
    final passwordfocusNode=FocusNode();
      @override
        initState(){
         super.initState();
       _isobscured=true;
        
       }
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          
        ),
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
          validator: (value) {
            if(value==null||value.isEmpty){
              return 'Please re-enter password';
            }
            return null;
          },
          
         focusNode: passwordfocusNode,
         controller: controllerpassword,
         obscureText: _ispassword,
         keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
                 suffixIcon: IconButton(
                 onPressed: (){
                  setState(() {
                       _ispassword=!_ispassword;
                   });
                    },
            icon: _ispassword  ? Icon(Icons.visibility,color: Colors.black,):Icon(Icons.visibility_off,color: Colors.grey,)
              ),
         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
           borderSide:BorderSide(color: Colors.black)
            
            
          ),
    
             focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)
             ),
             contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
             hintText: 'Mot de passe',
        ),
      )),
    );}
 

  
   
  

  Widget _textInput2({ hint, icon}) {
    var _isobscured;
      @override
        initState(){
         super.initState();
       _isobscured=true;
        
       }
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          
        ),
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
          validator: (value) {
            if(value==null||value.isEmpty){
              return 'Please re-enter your email';
            }
            return null;
          },
          
         controller: controlleremail,
         keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
                 
         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
           borderSide:BorderSide(color: Colors.black)
            
            
          ),
    
             focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)
             ),
             contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
             hintText: 'Adresse e-mail ',
        ),
      )),
    );
  }
}
