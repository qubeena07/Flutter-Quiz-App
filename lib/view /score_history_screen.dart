import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';
import 'package:quiz_app/widgets/drawer_widget.dart';

class ScoreHistoryScreen extends StatefulWidget {
  const ScoreHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ScoreHistoryScreen> createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Stream<QuerySnapshot> scores =
      FirebaseFirestore.instance.collection('score').snapshots();
  var useremail = '';
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    useremail = await getUseremail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log(scores.toString(), name: "score valuee");
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // iconTheme: const IconThemeData(
          //   color: Colors.black, //change your color here
          // ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Text(
              "Your Score Sheet",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                //color: Colors.blackz
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              child: Expanded(
                child: StreamBuilder(
                    stream: scores,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final scoreData = snapshot.requireData;

                      return ListView.builder(
                          itemCount: scoreData.size,
                          itemBuilder: (context, index) {
                            if (scoreData.docs[index]['email'] == useremail) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5, top: 5),
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      scoreData.docs[index]['score'].toString(),
                                      style: TextStyle(fontSize: 25.sp),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 209, 205, 205),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              );

                              // Center(
                              //   child: Text(
                              //     scoreData.docs[index]['score'].toString(),
                              //     style: TextStyle(fontSize: 25.sp),
                              //   ),
                              // );
                            } else if (scoreData.docs[index]['score']
                                .toString()
                                .isEmpty) {
                              return const Center(
                                child: Text("No score yet"),
                              );
                            }
                            // title: Text(scoreData.docs[index]['score'].toString()),

                            log(scoreData.docs[index]['email'].toString(),
                                name: "email value");
                            log(useremail, name: "email value 11");

                            // }
                            return Container();
                          });
                    }),
              ),
            ),
          ],
        ));
  }
}
