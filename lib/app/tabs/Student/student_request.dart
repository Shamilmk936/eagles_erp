import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';
import 'RegisterForm.dart';
import 'StudentSinglePageView.dart';

class StudentRequest extends StatefulWidget {
  const StudentRequest({Key key}) : super(key: key);

  @override
  _StudentRequestState createState() => _StudentRequestState();
}

class _StudentRequestState extends State<StudentRequest> {

  TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=10;

  List studentList=[];
  List allStudents=[];
  getStudents(){
    FirebaseFirestore.instance
        .collection('candidates')
        .where('verified',isEqualTo: 0)
        .orderBy('date',descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {
      studentList=[];
      for(var students in event.docs){
        studentList.add(students.data());
        allStudents.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });

    print(studentList.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      print('  next  ');
      print(lastDoc.toString());
      getStudents();
    } else {
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 0)
          .orderBy('date',descending: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        studentList = [];
        for (DocumentSnapshot orders in event.docs) {
          studentList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print(studentList.length.toString()+'                mmmmmm');
        print(lastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getStudents();
    } else {
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 0)
          .orderBy('date',descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        studentList = [];
        for (DocumentSnapshot orders in event.docs) {
          studentList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }

  searchStudent(String search){
    studentList.clear();
    for(var searchItem in allStudents){

      if(searchItem['name'].toUpperCase().toString().contains(search.toUpperCase())){
        print('bbb');
        studentList.add(searchItem);
      }
    }
    if(mounted){
      setState(() {

      });
    }
    print(studentList.length.toString()+'          nnn');
  }

  void reject_studentRequest(
      String course,
      List emailList,
      String name,
      String intake
      ) async {

    FirebaseFirestore.instance.collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body><p>Helo $name</p>'
          '<p></p>'
          '<p>Your admission for <var>$course</var> for the academic year <var>$intake</var> with Live To Smile Digital Academy is Rejected.</p>'
          '<p>Amount will be refunded with in 5 days</p>'
          '<p></p>'
          '<p></p>'
          '<p>Better luck next time</p>'
          '<p>Coordinator-<var>$course</var></p>'
          '<p></p>'
          '</body>',
      'emailList':emailList,
      'status':'Admission request rejected'
    });

    print('eeee');
  }

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    getStudents();
    // updateProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Students Request',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  obscureText: false,
                                  onChanged: (text){
                                    if(text.isNotEmpty){
                                      searchStudent(text);
                                    }else{
                                      getStudents();
                                    }
                                    setState(() {

                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText: 'Please Enter Name',
                                    labelStyle: FlutterFlowTheme
                                        .bodyText2
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: ()  {
                                  search.clear();
                                  getStudents();
                                  setState(() {

                                  });
                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle: FlutterFlowTheme
                                      .subtitle2
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              studentList.length==0?
              Center(child: CircularProgressIndicator(),):
              SizedBox(
                width:
                // double.infinity,
                MediaQuery.of(context).size.width*0.85,
                child: DataTable(
                  horizontalMargin: 10,
                  columnSpacing:20,

                  columns: [
                    DataColumn(
                      label: Text("S.Id ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                    ),
                    DataColumn(
                      label: Text("Date ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                    ),
                    DataColumn(
                      label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                    ),
                    DataColumn(
                      label: Text("Mobile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Course",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("University",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                  ],
                  rows: List.generate(
                    studentList.length,
                        (index) {

                      String name='${studentList[index]['name']} ${studentList[index]['lastName']}';
                      String mobile=studentList[index]['phoneCode']+studentList[index]['mobile'];
                      String email=studentList[index]['email'];
                      String course=CourseIdToName[studentList[index]['course']];
                      String university=UniversityIdToName[studentList[index]['university']];
                      String className=ClassIdToName[studentList[index]['classId']];

                      return DataRow(
                        color: index.isOdd?
                        MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                            :MaterialStateProperty.all(Colors.blueGrey.shade50),

                        cells: [
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.05,
                            child: SelectableText(studentList[index]['studentId'],  style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),),
                          )),
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.06,
                            child: SelectableText(dateTimeFormat('d-MMM-y', studentList[index]['date'].toDate()),
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),),
                          )),
                          DataCell(SelectableText(name,  style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.1,
                            child: SelectableText(mobile,style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),),
                          )),
                          DataCell(SelectableText(email,  style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(course??'',style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ))),
                          DataCell(  Text(university??'',style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),),
                          DataCell(  Text(className??'',style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),),
                          DataCell(
                            FFButtonWidget(
                              onPressed: () async {

                              await  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0)
                                      ),
                                      title: Text('Change Access ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: (){
                                            Navigator.of(context, rootNavigator: true).pop(false);
                                          },
                                          child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              )
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: (){

                                            FirebaseFirestore.instance
                                                .collection('candidates')
                                            .doc(studentList[index]['studentId'])
                                            .update({
                                              'verified':2,
                                            });
                                            setState(() {

                                            });

                                            String course=CourseIdToName[studentList[index]['course']];
                                            String intake=InTakeIdToName[studentList[index]['inTake']];
                                            List emailList=[];
                                            emailList.add(studentList[index]['email']);
                                            reject_studentRequest(course,emailList,name,intake);

                                            Navigator.of(context, rootNavigator: true).pop(false);
                                          },
                                          child: Text(
                                              'Reject',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red
                                              )
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection('candidates')
                                                .doc(studentList[index]['studentId'])
                                                .update({
                                              'verified':1,
                                            });
                                            setState(() {

                                            });
                                            Navigator.of(context, rootNavigator: true).pop(false);
                                          },
                                          child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue
                                              )
                                          ),
                                        )
                                      ],
                                    )
                                );
                              setState(() {

                              });
                              },
                              text: studentList[index]['verified'] == 0
                                  ? 'Pending'
                                  : 'Blocked',
                              options: FFButtonOptions(
                                width: 80,
                                height: 30,
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.subtitle2
                                    .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          ),
                          DataCell(  Row(
                            children: [
                              FFButtonWidget(
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentSinglePageView(
                                    id: studentList[index]['studentId'],
                                  )));

                                },
                                text: 'View',
                                options: FFButtonOptions(
                                  width: 80,
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

                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  // Text(pageIndex.toString()),
                  if (search.text == '')
                    if (pageIndex != 0)
                      ElevatedButton(
                        onPressed: () {
                          prev();
                        },
                        child: Text('Prev'),
                      ),
                  if (search.text == '')

                    studentList.length<limit||studentList.length==0?
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
