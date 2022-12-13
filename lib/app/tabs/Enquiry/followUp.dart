import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import 'package:rating_bar/rating_bar.dart';

class FollowUpPage extends StatefulWidget {
  const FollowUpPage({Key key}) : super(key: key);

  @override
  _FollowUpPageState createState() => _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double ratingStar = 0;

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=10;
  List followUpList=[];
  getFollowUp(){
    FirebaseFirestore.instance.collection('followUp')
        .where('done',isEqualTo: false)
        .orderBy('next',descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {
      followUpList=[];
      for(var students in event.docs){
        followUpList.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(followUpList.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getFollowUp();
    } else {
      FirebaseFirestore.instance.collection('followUp')
          .where('done',isEqualTo: false)
          .orderBy('next',descending: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        followUpList = [];
        for (DocumentSnapshot orders in event.docs) {
          followUpList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});print('  next  ');
          print(followUpList.length.toString()+'                mmmmmm');
          print(lastDoc.toString()+'                jjj');
        }

      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getFollowUp();
    } else {
      FirebaseFirestore.instance.collection('followUp')
          .where('done',isEqualTo: false)
          .orderBy('next',descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        followUpList = [];
        for (DocumentSnapshot orders in event.docs) {
          followUpList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(followUpList.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }


 @override
  void initState() {
   getFollowUp();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding( padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'FollowUp List',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
              ),

              followUpList.length==0
                  ?LottieBuilder.network('https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',height: 500,)
                  : SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 10,
                        columns: [
                          DataColumn(
                            label: Text("Enquiry Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                          ),
                          DataColumn(
                            label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("FollowUp Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Staff",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Review",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ),

                        ],
                        rows: List.generate(
                          followUpList.length,
                              (index) {

                            String eId=followUpList[index]['eId'];
                            Timestamp date=followUpList[index]['date'];
                            String status=followUpList[index]['status'];
                            Timestamp followUpdate=followUpList[index]['next'];
                            String StaffId=followUpList[index]['userId'];


                            return DataRow(
                              color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                              cells: [
                                DataCell(Text(eId,     style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),)),
                                DataCell(Container(
                                width:MediaQuery.of(context).size.width*0.06,
                                child:  Text( dateTimeFormat('d-MMM-y', date.toDate()),
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                )
                                  ),
                                DataCell(StreamBuilder<DocumentSnapshot>(
                                  stream:FirebaseFirestore.instance.collection('enquiry').doc(eId).snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return Text('');
                                    }
                                    var UserName=snapshot.data.get('name');
                                    return Text(UserName??'',     style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),);
                                  }
                                )),
                                DataCell(Text(status,  style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),)),
                                DataCell(Container(
                                width:MediaQuery.of(context).size.width*0.06,
                                child:  Text( dateTimeFormat('d-MMM-y', followUpdate.toDate()),
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),))
                                ),
                                DataCell(Text(currentUserIdToName[StaffId],
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),

                                //REVIEW
                                DataCell( Row(
                                  children: [

                                    RatingBar(
                                      onRatingChanged: (rating) {
                                        setState((){
                                          ratingStar = rating;
                                        });

                                      },
                                      filledIcon: Icons.star,
                                      emptyIcon: Icons.star_border,size: 17,filledColor: Colors.yellow,
                                    ),

                                  ],
                                ),
                                   ),

                                DataCell(   Row(
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {

                                        bool proceed = await alert(context, 'FollowUp Completed?');

                                        if(proceed){
                                          FirebaseFirestore.instance.collection('followUp').doc(followUpList[index]['id']).update({
                                            'done':true,
                                            'rating':ratingStar,
                                          });

                                          ratingStar=0;
                                            setState(() {
                                              ratingStar=0;
                                            });


                                            showUploadMessage(context, '${eId} Follow up completed');


                                        }

                                      },
                                      text: 'Done',
                                      options: FFButtonOptions(
                                        width: 90,
                                        height: 30,
                                        color: Colors.teal,
                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ],
                                ),),

                                // DataCell(Text(fileInfo.size)),
                              ],
                            );
                          },
                        ),
                      ),

              ),
              Row(
                children: [
                  // Text(pageIndex.toString()),

                    if (pageIndex != 0)
                      ElevatedButton(
                        onPressed: () {
                          prev();
                          setState(() {

                          });
                        },
                        child: Text('Prev'),
                      ),

                    followUpList.length<limit||followUpList.length==0?
                    Container():
                    ElevatedButton(
                      onPressed: () {
                        next();
                        setState(() {

                        });
                      },
                      child: Text('Next'),
                    ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
