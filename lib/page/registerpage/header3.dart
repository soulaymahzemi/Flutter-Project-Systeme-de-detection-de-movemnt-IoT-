import 'package:flutter/material.dart';

class HeaderContainer3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
     SingleChildScrollView(
       child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
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


            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))
            
            
            
            
            
            ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 20,
                right: 20, child: Text('S’inscrire',
                 style: TextStyle(
                 fontSize: 40,
                 color: Colors.white,
                     fontFamily: 'Poppins-Medium',

                   fontWeight: FontWeight.w500,
                ),),
           ),
          
          ],
        ),
         ),
     );
  }
}