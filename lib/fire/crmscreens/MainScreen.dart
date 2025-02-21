// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../dashboard.dart';
// import 'AddScreen.dart';
// import 'ViewScreen.dart';
//
//
// class Mainscreen extends StatefulWidget {
//   const Mainscreen({super.key});
//
//   @override
//   State<Mainscreen> createState() => _MainscreenState();
// }
//
// class _MainscreenState extends State<Mainscreen> {
//
//   List<dynamic> cList = [];
//
//   bool isLoading = false;
//
//   bool isError = false;
//
//   Future<void> getData() async
//   {
//     setState(() {
//       isLoading = true;
//     });
//     try
//     {
//
//       Response response = await Dio().get("https://fir-d29ca-default-rtdb.firebaseio.com/bucklist.json");
//
//       if(response.data is List)
//       {
//         cList = response.data;
//       }else
//       {
//         cList = [];
//       }
//       isError =false;
//
//       isLoading=false;
//       setState(() {
//
//       });
//       print(response.data);
//     }
//     catch(e)
//     {
//       setState(() {
//         isError =true;
//         isLoading=false;
//       });
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//     }
//
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<dynamic> filterdata = cList.where((element)=>!(element?["completed"])??false).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70,
//         leading:    Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBuPUKhnjaYtqpQr001fP4eXAe21_ySDWLuA&s'),
//               ),
//             ),
//           ),
//         ),
//         title: Text('LimeCRM'),
//         actions: [
//           InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
//
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.person_add_alt_outlined,size: 30,),
//                   Text('Profile'),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: (){
//
//               getData();
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.refresh_outlined,size: 30,),
//                   Text('refresh'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>Addscreen(newIndex: cList.length))).then((value){
//             if(value == "refresh")
//             {
//               getData();
//             }
//           });
//         },
//         icon: Icon(Icons.save),
//         label: Text("Add Data"),
//       ),
//
//       body:RefreshIndicator(
//         onRefresh: ()=>getData(),
//         child: isLoading ? LinearProgressIndicator() : isError?Text("error"):
//         filterdata.length<1 ? Text("no data in bucklist"):ListView.builder(
//             itemCount: cList.length,
//             itemBuilder: (BuildContext,index)
//             {
//
//               return InkWell(
//                 onTap: (){
//                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewscreen(
//                   //   CName: cList[index]['CName']?? "null",
//                   //   index: index,
//                   // ))).then((value)
//                   // {
//                   //   if(value== "refresh")
//                   //   {
//                   //     getData();
//                   //   }
//                   // }
//                   // );
//                 },
//                 child: (cList[index] is Map && (!(cList[index]?["completed"]??false)))? ListTile(
//                   title: Text(cList[index]?['CName']?? "null"),
//                 ):SizedBox(),
//               );
//             }
//         ),
//       ),
//       /*RefreshIndicator(
//         onRefresh: getData,
//         child:isLoading ? LinearProgressIndicator() : isError? Text("error"):
//         filterdata.length<1 ?Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               Text('No Data in CRM'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 300,
//                   width: 300,
//                   decoration: BoxDecoration(
//
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                           'https://static.vecteezy.com/system/resources/thumbnails/021/975/492/small/search-not-found-3d-render-icon-illustration-with-transparent-background-empty-state-png.png'),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ) :
//         ListView.builder(
//           itemCount: cList.length,
//             itemBuilder: (BuildContext ,index)
//               {
//                 return  InkWell(
//
//                   onTap: ()
//                   {
//
//                   },
//                   child: cList[index] is Map ?
//                   ExpansionTile(
//
//                     title: Text(cList[index]?['CName'] ?? ''),
//                     subtitle: Text(cList[index]?['email'] ?? ''),
//                     leading:  Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             fit: BoxFit.contain,
//                             image: NetworkImage(cList[index]?['image'] ?? '')
//                           ),
//                         ),
//                       ),
//                     ),
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Notes: '+cList[index]?['Notes'] ?? ''),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Meetings: '+cList[index]?['meeting'] ?? ''),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('PhoneNo: '+cList[index]?['phone'] ?? ''),
//                           ),
//                           Center(
//                               child: OutlinedButton(
//                                   onPressed: (){
//                                     Navigator.push(context, MaterialPageRoute(
//                                         builder: (context)=>Viewscreen(
//                                           CName: cList[index]?['CName'] ?? '',
//                                           phone: cList[index]?['phone'] ?? '',
//                                           email: cList[index]?['email'] ?? '',
//                                           meeting: cList[index]?['meeting'] ?? '',
//                                           Notes: cList[index]?['Notes'] ?? '',
//                                           image: cList[index]?['image'] ?? '',
//                                           index: index,
//
//                                         ))).then((value){
//                                           if(value == 'refresh')
//                                             {
//                                               getData();
//                                             }
//                                     });
//
//                           }, child: Text('View'))),
//                         ],
//                       ),
//                     ],
//                   )
//                       :const SizedBox(),
//                 );
//               }
//         ),
//       ),*/
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      Response response = await Dio().get(
          "https://fir-d29ca-default-rtdb.firebaseio.com/bucklist.json");

      if (response.data is List) {
        cList = response.data;
      } else {
        cList = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: getData, child: Text("Try again"))
        ],
      ),
    );
  }

  Widget ListDataWidget() {
    List<dynamic> filteredList = cList
        .where((element) => !(element?["completed"] ?? false))
        .toList();

    return filteredList.length < 1
        ?
    Center(
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
        )
        : ListView.builder(
        itemCount: cList.length,
        itemBuilder: (BuildContext context, int index) {
          return (cList[index] is Map &&
              (!(cList[index]?["completed"] ?? false)))
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card( 
              child: Container(
                padding: EdgeInsets.all(5),
                child: ExpansionTile(

                  leading:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                              cList[index]?['image'] ?? "",),
                          ),
                        ),
                      ),
                    ),
                  title: Text(cList[index]?['CName'] ?? ""),
                  subtitle:  Text(cList[index]?['email'] ?? ""),
                  children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Notes:',style: TextStyle(decoration: TextDecoration.underline),),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cList[index]?['Notes'] ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Meetings:',style: TextStyle(decoration: TextDecoration.underline),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cList[index]?['meeting'] ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Phone Number:',style: TextStyle(decoration: TextDecoration.underline),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cList[index]?['phone'] ?? ""),
                        ),
                        OutlinedButton(onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Viewscreen(
                                    index: index,
                                    CName: cList[index]['CName'] ?? "",
                                    phone: cList[index]['phone'] ?? "",
                                    email: cList[index]['email'] ?? "",
                                    meeting:cList[index]['meeting'] ?? "",
                                    Notes: cList[index]['Notes'] ?? "",
                                    image: cList[index]['image'] ?? "",
                                  );
                                })).then((value) {
                              if (value == "refresh") {
                                getData();
                              }
                            });

                        }, child: Text('View')),

                ]),
                  ],

                ),
              ),
            ),
          )
              : SizedBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Addscreen(newIndex: cList.length);
          })).then((value) {
            if (value == "refresh") {
              getData();
            }
          });
        },
        icon: Icon(Icons.save),
       label: Text("Add Data"),

      ),
    appBar: AppBar(
        toolbarHeight: 70,
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
              child: Column(
                children: [
                  Icon(Icons.person_add_alt_outlined,size: 30,),
                  Text('Profile'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){

              getData();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Icon(Icons.refresh_outlined,size: 30,),
                  Text('refresh'),
                ],
              ),
            ),
          ),
        ],

      ),
      body: RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: isLoading
              ? LinearProgressIndicator()
              : isError
              ? errorWidget(errorText: "Error connecting...")
              : ListDataWidget()),
    );
  }
}


