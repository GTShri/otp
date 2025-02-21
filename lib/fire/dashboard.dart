import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otpp/fire/splashscreen.dart';
import 'package:provider/provider.dart';

import '../main.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

    var themeProvider = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(

       title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
            child: Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hi,"),
                  ),

                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Email: '+ (user?.email ?? '').toString()),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( (user?.displayName ?? '').toString()),
              ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network( (user?.photoURL ?? 'null').toString() ?? '',height: 100,width: 100,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( (user?.phoneNumber ?? '').toString()),
              ),


                ],
                ),
                    ),
                    ),
          ),
         /// theme
          ListTile(
            onTap: (){},
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Theme '),
                ),
               Row(
            
                 children: [
                   Switch(value: themeProvider.isDarkModeCheck, onChanged: (value)
                   {
            
                     themeProvider.updateTheme(dark: value);
            
                   }),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(themeProvider.isDarkModeCheck ? "Dark mode" : 'LightMode'),
                   )
                 ],
               )
              ],
            ),
          ),

         SizedBox(height: 100,),
         /// sign out button
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {


                    showDialog(context: context, builder: (context)
                    {
                      return AlertDialog(
                        title: Text('Do you want to logout'),
                        actions: [
                          InkWell(
                              onTap:() async
                      {
                        await  FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context)=>SplashScreen()),(route)
                        {
                          return false;
                        });

                      },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('yes'),
                              )),
                          InkWell(
                              onTap:()
                              {
                               Navigator.pop(context, );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('cancel'),
                              )),
                        ],
                      );
                    });

                  }, child: Text("Logout")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
