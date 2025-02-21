import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otpp/fire/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child:
      App()
  )
  );
}
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ThemeProvider>(context,listen: false).load();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkModeCheck
          ? ThemeData.dark(useMaterial3: true)
          :ThemeData.light(useMaterial3: true),
      // routes: {
      //   '/add':(context)
      //   {
      //     return MyApp();
      //   },
      //   '/add':(context)
      //   {
      //     return ad();
      //   },
      //
      //
      // },
      // initialRoute: '/add',
      home:
      //Mainscreen(),
      SplashScreen()


    );
  }
}
/*
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

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



  var otpController = TextEditingController();
  var numController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = "";


  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      }
    } on FirebaseAuthException catch (e) {
      print("catch");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  hintText: 'Enter valid number'
              ),
              controller: numController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter valid password'
              ),
              controller: otpController,
            ),
          ),
          TextButton(onPressed: () {
            fetchotp();
          }, child: const Text("Fetch OTP"),),
          TextButton(onPressed: () {
            verify();
          }, child: const Text("Send")),

          TextButton(onPressed: () {
            signInWithGoogle(context);
         //  AuthService().signInWithGoogle();
          }, child: const Text("google"))
        ],
      ),
    );
  }
  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential =
    PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }
  Future<void> fetchotp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: numController.text,
      //'+911234567890',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }
}
*/


class ThemeProvider extends ChangeNotifier {

  bool isDarkModeCheck = true;

   updateTheme({required bool dark}) async
  {
    isDarkModeCheck = dark;
    notifyListeners();


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeCheck', isDarkModeCheck);
  }




  load() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeCheck =  prefs.getBool('isDarkModeCheck',) ?? true;

    notifyListeners();
  }



}

/*

class sett extends StatefulWidget {
  const sett({super.key});

  @override
  State<sett> createState() => _settState();
}

class _settState extends State<sett> {
  @override
  Widget build(BuildContext context) {

    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
              value: themeProvider.isDarkModeCheck,
              onChanged: (value)
              {
                themeProvider.updateTheme(dark: value);
              }),
        ],
      ),
    );
  }
}
*/
