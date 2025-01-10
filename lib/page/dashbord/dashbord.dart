import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/page/dashbord/texte.dart';
import 'package:flutter_application_1/page/historique.dart/historique.dart';
import 'package:flutter_application_1/page/pagedegarde/login.dart';

import '../notfication/notfication.dart';

  
class dashbord extends StatefulWidget{
  const dashbord ({Key? key}):super(key: key);

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> 
  {
   final String imageUrl =
      'https://user-images.githubusercontent.com/58719230/218909229-67867fec-6f4a-43fb-bfc3-33d6bc42ae2e.png';

  Widget build(BuildContext context) =>Scaffold(
   appBar:AppBar( 
 
    title: const Text('Dashbord'),
    backgroundColor: Colors.black,
   centerTitle: true,
     actions: [
     
      ],
   
   ),
   body:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
                  
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 310,
                        fit: BoxFit.cover,
                      ),
                      
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      
                      child: 
                    
                    DetectionPage())
                      ],
                    ),
                              
                          
                        
                  
                  
                  drawer:  NavigationDrawer(),

                  
                  
                  );
                }
        class NavigationDrawer extends StatelessWidget{

        @override
        Widget build(BuildContext context) =>Drawer(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            builMenuItems(context),
          ],
        ),
      ),
        );
        
final User? user = FirebaseAuth.instance.currentUser;

 
 Widget buildHeader(BuildContext context)=> DrawerHeader(

   decoration: BoxDecoration(
   color: logoGreen
   ),  
  
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('signed in as ', style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            
          )
          ),
          SizedBox(height: 9,),
          Text(' ${user?.email != null ? user!.email!.split('@')[0] : "Unknown"}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            
          ),),
        ],
      )
    ],
    
  ),
  
 );
  
  Widget builMenuItems(BuildContext context) => Column(
    children: [
      ListTile(
        leading:const Icon(Icons.home_outlined),
        title: const Text('Dashbord'),
        onTap: () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const dashbord())))
      ),
     
         ListTile(
        leading:const Icon(Icons.history_edu_outlined),
        title: const Text('historique'),
      
         ),

             ListTile(
        leading:const Icon(Icons.history_edu_outlined),
        title: const Text('logOUt'),
       onTap: (){
          FirebaseAuth.instance.signOut();
     Navigator.of(context).pushReplacement(
                      
     MaterialPageRoute(builder: ((context) => LoginPage())));
        },
         ),
        
      
      
    ],
  );
}


 

