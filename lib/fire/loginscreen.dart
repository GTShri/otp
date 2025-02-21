import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otpp/fire/Signup.dart';
import 'package:otpp/fire/ctrl/loginController.dart';


import 'crmscreens/MainScreen.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  ///
  final GoogleSignIn  googleSignIn = GoogleSignIn(
    clientId:
    "50297548634-7vrj2bckcctsqu92r9ighm5ikkq4g3ad.apps.googleusercontent.com",
  );

  Future<User?> signInWithGoogle(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }
      final user = userCredential.user;
      if (user != null) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>Mainscreen()),(route)
        {
          return false;
        });
        // setState(() {
        //   name=user!.displayName!;
        //   gmail=user!.email!;
        // });
        // print(_auth.currentUser);
        // createuser();
      }
    } catch (e) {
      print(e);
    }
  }

  ///

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBuPUKhnjaYtqpQr001fP4eXAe21_ySDWLuA&s'),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(),

                ),
                validator: (input) {
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(input!)) {
                    return 'Please enter valid mail id';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
                validator: (input) {
                  if ( !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(input!))
                  {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          
                          if(_key.currentState!.validate())
                            {
                              LoginCtrl.Loginn(
                                  context: context,
                                  email: email.text,
                                  password: password.text);
                              

                            }
                          
                         
                        },
                        child: Text("Login")),
                  ),
                ),

              ],
            ),
            Row(

              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {

                          signInWithGoogle(context);
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Padding(
                              padding: const EdgeInsets.only(top:8,bottom: 8,right: 20),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                NetworkImage('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                              ),
                            ),
                            Text("Sign in with Google"),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Don\'t have the account '),
                ),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      =>SignUp()
                      ));
                    },
                    child:  Text(
                      "Sign Up?",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.blue,
                              offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    )),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
