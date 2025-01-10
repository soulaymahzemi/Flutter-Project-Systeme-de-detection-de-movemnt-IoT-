import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Esppage/ajoutecarte.dart';
import 'package:flutter_application_1/page/registerpage/text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../firebase_options.dart';

Future<void> scanne() async {
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

}


 class Scannecarte  extends StatefulWidget {
   Scannecarte({super.key}) {
  }



  @override
  State<Scannecarte> createState() => _scannerState();

}

  

class _scannerState extends State<Scannecarte> {
  
  final qrkey=GlobalKey(debugLabel: 'QR');
    QRViewController? controller;
    Barcode? barcode ;

  @override
   void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  void reassemble() async{
    super.reassemble();
    if(Platform.isAndroid){
     controller!.pauseCamera();
    }else if (Platform.isIOS){
     controller!.resumeCamera();

    }
  }
   
          @override
  Widget build(BuildContext context) =>SafeArea(
    child: Scaffold(
      body: Stack(alignment:Alignment.center,
      children: [
        buildQrview(context),
        Positioned(child: buildResult(),bottom: 100),
        Positioned(child: buildcontrolbuttons(),top: 50,),
      ],
      ),
      

    ),
  );

   
  Widget buildQrview(BuildContext context){

      var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
      
        return QRView(
          
        key: qrkey, 
        onQRViewCreated: onQRViewCreated,
        
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderWidth: 10,
          borderLength:30 ,
          borderRadius: 10,
          cutOutSize: scanArea,

         ),
    

            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),

           );
 
            }


      ajouteqrcode( String barcode ) 
    {
         
         
        Navigator.push(context,MaterialPageRoute(builder: (context)=> ajoutecartee(barcode: barcode,  ) ));
 
    }
 
   
  
       

  void onQRViewCreated(QRViewController controller ) {

    setState(() {
      this.controller=controller;
    });
    controller.scannedDataStream.listen((barcode) {
      ajouteqrcode(barcode.code!);
  
      setState(() {


        this.barcode=barcode;

    });
  });
  }
    

    
  
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
   
     
  //resulta
    Widget buildResult() => 
     Container(
      width: 300, 
      padding: EdgeInsets.all(22),
       decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Color.fromARGB(57, 249, 248, 248),
      ),
      child:  
      Text(
        barcode!=null? 'Result: ${barcode!.code}':'Scan a code',
        maxLines: 3
      ),
      );
      
 
  //flash **camera 
  buildcontrolbuttons()=>Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       IconButton(onPressed: () async
        {
          await controller?.toggleFlash();
          setState(()  {
          
          });
        }, 
        icon: FutureBuilder<bool?>(
          future: controller?.getFlashStatus(),
          builder: (context,snapshot){
            if(snapshot.data!=null){
              return  Icon(
                snapshot.data! ?Icons.flash_on : Icons.flash_off );
            }else{
              return Container();
            }
          },
          ),
       ),
        IconButton(onPressed: () async
        {
          await controller?.flipCamera();
          setState(() {
            
          });
        }, 
        icon:FutureBuilder(
          future: controller?.getCameraInfo(),
          builder: (context,snapshot)
          {
            if(snapshot.data!=null){
              return  Icon(Icons.switch_camera);
             }else{
              return Container();
            }
          },
          ),
      ),
      ],
    ),
  );
  
  
}
   