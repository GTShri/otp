import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../dashboard.dart';
import 'AddScreen.dart';
import 'ViewScreen.dart';


class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {

  List<dynamic> cList = [];

  bool isLoading = false;

  bool isError = false;

  Future<void> getData() async
  {
    setState(() {
      isLoading = true;
    });
    try
    {

      Response response = await Dio().get("https://fir-d29ca-default-rtdb.firebaseio.com/bucklist.json");

      if(response.data is List)
      {
        cList = response.data;
      }else
      {
        cList = [];
      }
      isError =false;

      isLoading=false;
      setState(() {

      });
      print(response.data);
    }
    catch(e)
    {
      setState(() {
        isError =true;
        isLoading=false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    List<dynamic> filterdata = cList.where((element)=>!(element?["completed"])??false).toList();

    return Scaffold(
      appBar: AppBar(
        leading:    Padding(
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
        title: Text('LimeCRM'),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.person_add_alt_outlined,size: 30,),
            ),
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Addscreen(newIndex: cList.length))).then((value){
            if(value == "refresh")
            {
              getData();
            }
          });
        },
        icon: Icon(Icons.save),
        label: Text("Add Data"),
      ),

      body: RefreshIndicator(
        onRefresh: getData,
        child:isLoading ? LinearProgressIndicator() :
        isError ? Text('Error Url'):
        filterdata.length < 1 ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('No Data in CRM'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/021/975/492/small/search-not-found-3d-render-icon-illustration-with-transparent-background-empty-state-png.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ) :
        ListView.builder(
          itemCount: cList.length,
            itemBuilder: (BuildContext ,index)
              {
                return  InkWell(

                  onTap: ()
                  {

                  },
                  child:(cList[index] is Map && (!(cList[index]?["completed"]??false))) ?
                  ExpansionTile(

                    title: Text(cList[index]['CName'] ?? 'null'),
                    subtitle: Text(cList[index]['email'] ?? 'null'),
                    leading:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(cList[index]['image'] ?? 'null')
                          ),
                        ),
                      ),
                    ),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Notes: '+cList[index]['Notes'] ?? 'null'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Meetings: '+cList[index]['meeting'] ?? 'null'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('PhoneNo: '+cList[index]['phone'].toString() ?? 'null'),
                          ),
                          Center(
                              child: OutlinedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>Viewscreen(
                                          CName: cList[index]['CName'] ?? 'null',
                                          phone: cList[index]['phone'] ?? 'null',
                                          email: cList[index]['email'] ?? 'null',
                                          meeting: cList[index]['meeting'] ?? 'null',
                                          Notes: cList[index]['Notes'] ?? 'null',
                                          image: cList[index]['image'] ?? 'null',
                                          index: index,

                                        ))).then((value){
                                          if(value == 'refresh')
                                            {
                                              getData();
                                            }
                                    });

                          }, child: Text('View'))),
                        ],
                      ),
                    ],
                  )
                      :SizedBox(),
                );
              }
        ),
      ),

    );
  }
}
