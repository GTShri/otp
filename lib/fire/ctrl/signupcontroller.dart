


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../crmscreens/MainScreen.dart';


class SignUpCtrl{





 static Future<void> createAcc({required BuildContext context,required String email,
 required String password
 }) async {
    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context)=>Mainscreen()),(route)
      {
        return false;
      });

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account has been successfully created👍')));
    }
    catch(e)
    {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


}