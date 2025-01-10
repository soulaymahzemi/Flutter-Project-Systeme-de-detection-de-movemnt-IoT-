import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/pagedegarde/background.dart';
import 'package:flutter_application_1/page/pagedegarde/login.dart';


class GetStartpage extends StatefulWidget {
  const GetStartpage({super.key});

  @override
  State<GetStartpage> createState() => _GetStartpageState();
}

class _GetStartpageState extends State<GetStartpage> {
 
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
              BackgroundImage(),
      
       Container(
    
       
        child: Center(
          child: Padding(
            padding:  EdgeInsets.only(
            top: MediaQuery.of(context).size.height *0.10,
            left: 30
    
            ),
            child: Column(
              
              children: [
                Text('welcome to ESP   APP',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                )
                ),
                
                SizedBox(height: 530),
                 ElevatedButton(onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder:  (context)=> LoginPage()));
                  });
                 },
                  style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.transparent,
                 padding:EdgeInsets.all(8)
                
                
                   ),       
                  child: Center(
                    child: Row(
                     children: [
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10,),
                      Text('Explore Now',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        
                      ),
                      ),
                      
                    ],
                             ),
                  ))
              ],
              
            ),
          ),
        ),
      ),
   ] );
    
    }}




















     /* backgroundColor:Colors.white,
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
      height: 250,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: 
                AssetImage('images/download.png'),
                fit: BoxFit.fill),
                
              ),
            )
          ),
        ],
      ),
    ),
      SizedBox(height: 30,),
      
      Container(
        height: 300,
         width:double.infinity ,
         decoration: BoxDecoration(
         
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
            
            
          ),
          boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 4,
        offset: Offset(4, 8), // Shadow position
      ),
    ],
         ),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      
              children: [
              Text("Welcome to ESP APP !",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 30,),
                ElevatedButton.icon(
                  
                  style: buttonStyle,
                  onPressed:  (){
                 Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:
                     (context )=> QRscanner() ,
      
                   
                    )); 
                 }, 
                  icon:  Icon(Icons.key),
                   label: Text('Scan QRCODE ',style: TextStyle(fontWeight: FontWeight.normal),)
                 ),

                 SizedBox(height: 30,),
                Container(
                child: 
                TextField(
                  style: TextStyle(fontSize: 2),
      
                  decoration: InputDecoration(
                    labelText: 'password',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                ),
                ),
              
               ),
          
                 /*  GestureDetector(
                  child: Text("forgot password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(126, 59, 135, 62),
                    fontSize: 20,
                  ),),
                  
                )  , */     
            ]  ),
          ),
      ),
        
      ],
    ),*/
  








   /*  body: SafeArea(
     child: Padding(
     padding: EdgeInsets.symmetric(
      horizontal: 24,
     ),
     
     child: Column(

      children: [
        Padding(padding:EdgeInsets.only(top: 40),
        child:
         Image.asset('images/download.png'),
         ),
         SizedBox(height: 50,),
  ]))));}}
        @override
        Widget build1(BuildContext context){
          return 
                   Container(

          height: 300,
         width:double.infinity ,
         decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
            
            
          ),
          
         ),
         child:  Padding(padding: EdgeInsets.symmetric(vertical: 24),
         child: Column( 
           children: [ 
                    
            Text('QR CODE',style: headerOne,),
           
            SizedBox(height: 90,),
          TextFormField(
                    
                    
                    keyboardType:  TextInputType.emailAddress,
                    
                    decoration:   
                    InputDecoration( 
                      
                      hintText: 'password',
                      icon: Icon(Icons.key),
                         
                
                    ),
                
                      
                  
                                    

                  ),
   
            ElevatedButton.icon(
              
              style:buttonStyle
              ,
              
              onPressed: (){
             Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:
                   (context )=> QRscanner() ,

                 
                  )); 
            },
            icon:  Icon( Icons.camera_alt),
            label: Text('Scan'),
             ),
          ],
         ),
         ),
         );
      
    
  }*/

