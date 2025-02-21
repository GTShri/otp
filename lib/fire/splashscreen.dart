import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'crmscreens/MainScreen.dart';
import 'loginscreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 2),(){
     if(user == null)
       {
         openLogin();
       }else
         {
           openDash();
         }
    });

    super.initState();
  }


  void openLogin()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
  }

  void openDash()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Mainscreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBuPUKhnjaYtqpQr001fP4eXAe21_ySDWLuA&s'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


