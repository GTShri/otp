


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';

class LoginCtrl{





 static Future<void> Loginn({required BuildContext context,required String email,
 required String password
 }) async {
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context)=>Dashboard()),(route)
      {
        return false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('LogIn Successfull👍')));
    }
    catch(e)
    {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


}