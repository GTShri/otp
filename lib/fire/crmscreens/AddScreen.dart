import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Addscreen extends StatefulWidget {
  int newIndex;

   Addscreen({
     super.key,
     required this.newIndex,

   });

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {



  TextEditingController CName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController meeting = TextEditingController();
  TextEditingController Notes = TextEditingController();
  TextEditingController image = TextEditingController();

  final _key = GlobalKey<FormState>();

  Future<void> AddListCrm() async
  {
    try
    {

      Map<String,dynamic> data = {
        "CName": CName.text,
        "phone": phone.text,
        "email":email.text,
        "meeting": meeting.text,
        "Notes": Notes.text,
        "image":image.text,

        "completed":false
      };

      Response response = await Dio().patch("https://fir-d29ca-default-rtdb.firebaseio.com/bucklist/${widget.newIndex}.json",data: data);

      Navigator.pop(context,"refresh");

      setState(() {

      });
    }catch(e)
    {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBuPUKhnjaYtqpQr001fP4eXAe21_ySDWLuA&s'),
                ),
              ),
            ),
          ),
        ],
        title: Text('LimeCRM'),
      ),

      body: Form(
        key: _key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: CName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Company Name"),
                  prefixIcon: Icon(Icons.corporate_fare_outlined),
                  border: OutlineInputBorder(),

                ),
                validator: (input) {
                 if(input == null || input.isEmpty)
                 {
                   return 'Enter Company Name';
                 }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: Text('+91 '),
                  prefixIcon: Icon(Icons.phone),
                  label: Text("Phone Number"),
                  border: OutlineInputBorder(),
                ),
                validator: (input) {
                  if ( !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(input!))
                  {
                    return 'Please enter valid number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.mail),
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
                controller: meeting,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  label: Text("Meeting"),
                  prefixIcon: Icon(Icons.meeting_room_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (input) {
                  if (input == null || input.isEmpty)
                  {
                    return 'Please enter valid data';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: Notes,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                  label: Text("Notes"),
                  prefixIcon: Icon(Icons.note_add_rounded),
                  border: OutlineInputBorder(),

                ),
                validator: (input) {
                  if (input==null || input.isEmpty) {
                    return 'Please enter valid data';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: image,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  label: Text("Image"),
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(),
                ),
                validator: (input) {
                  if ( !RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?').hasMatch(input!))
                  {
                    return 'Please enter valid Image URL';
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

                            AddListCrm();

                          }


                        },
                        child: Text("Add")),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
