import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class Viewscreen extends StatefulWidget {
  String CName;
  String phone;
  String email;
  String meeting;
  String Notes;
  String image;
  int index;


   Viewscreen({
     super.key,
     required this.CName,
     required this.phone,
     required this.email,
     required this.meeting,
     required this.Notes,
     required this.image,
     required this.index,
   });

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {



  Future<void> listDelete() async
  {
    Navigator.pop(context);
    try{
      Response response = await Dio().delete("https://fir-d29ca-default-rtdb.firebaseio.com/bucklist/${widget.index}.json");
      Navigator.pop(context,"refresh");
    }catch(e)
    {
      print(e);
    }
  }

  Future<void> markListcomplete() async
  {
    try
    {

      Map<String,dynamic> data = {
        "completed":true,
      };

      Response response = await Dio().patch("https://fir-d29ca-default-rtdb.firebaseio.com/bucklist/${widget.index}.json",data: data);

      Navigator.pop(context,"refresh");
    }catch(e)
    {
      print(e);
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

          PopupMenuButton(
            tooltip: 'More',
            onSelected: (value)
            {
              if(value==1)
              {
                showDialog(context: context, builder: (context)
                {
                  return AlertDialog(
                    title: Text('Do you want to delete?'),
                    actions: [
                      InkWell(onTap:(){Navigator.pop(context);},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("cancel"),
                          )),
                      InkWell(
                          onTap:()
                          {
                            listDelete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("confirm"),
                          )),
                    ],
                  );
                });

              }
              if (value==2) {
                markListcomplete();

              }
            },
            itemBuilder: (context)
            {
              return [
                PopupMenuItem(
                    value: 1,
                    child: Text("Delete")),
                PopupMenuItem(
                    value:2,child: Text("Task Completed")),
              ];
            },
          )

        ],
        title: Text('LimeCRM'),
      ),

      body: Container(
        height: double.infinity,
        width:double.infinity,
        padding: EdgeInsets.all(20),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Company Name: '+widget.CName),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Email ID: '+widget.email),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(widget.image)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Notes:",style: TextStyle(decoration: TextDecoration.underline)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.Notes ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Meetings:",style: TextStyle(decoration: TextDecoration.underline)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.meeting),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Phone Number:",style: TextStyle(decoration: TextDecoration.underline),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('+91 '+widget.phone),
              ),


                ],
              ),
        )
      ),
    );
  }
}
