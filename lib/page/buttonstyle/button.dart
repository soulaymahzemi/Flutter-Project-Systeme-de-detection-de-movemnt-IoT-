import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'colors.dart';


final ButtonStyle buttonStyle=ElevatedButton.styleFrom(
  minimumSize: Size(351, 55),
   backgroundColor: Colors.transparent,
  elevation: 0,
  
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
      
    ),
    side: BorderSide(color:Colors.grey)
    
    
  ),
  
);