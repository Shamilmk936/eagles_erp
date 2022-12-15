import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:smile_erp/flutter_flow/flutter_flow_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';

class NewSchedules extends StatefulWidget {
  const NewSchedules({Key key}) : super(key: key);

  @override
  _NewSchedulesState createState() => _NewSchedulesState();
}

class _NewSchedulesState extends State<NewSchedules> {


  // void schedule_class(
  //     String token,
  //     DateTime scheduledDate,
  //     String topic,
  //     ) async {
  //
  //   print('       SCHEDULING');
  //   FirebaseFirestore.instance.collection('webSchedules')
  //       .add({
  //     'header':{
  //       'Authorization':'Bearer $token',
  //       'Content-Type':"application/json",
  //     },
  //     'data':{
  //       'status':'Meeting Scheduled',
  //       "start_time": scheduledDate,
  //       "settings": {
  //         "agenda":topic,
  //         "topic":topic,
  //         "email_notification": "false",
  //         "registrants_confirmation_email": "false",
  //         "registrants_email_notification": "false",
  //         "registration_type": 1,
  //         "waiting_room": "true",
  //         "host_video":"true",
  //         "auto_recording":"cloud",
  //       }
  //     }
  //
  //   });
  //
  //   print('eeee');
  // }

  void class_schedulesEmail(
      String universityName,
      String course,
      List emailList,
      String userId,
      String branchName,
      String className,
      DateTime scheduledDate,
      String tutorName,
      String subject,
      ) async {

    FirebaseFirestore.instance.collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body><p>Hi </p>'
          '<p>This is a remainder for your upcoming class scheduled as follows:</p>'
          '<p></p>'
          '<p></p>'
          '<p>Date : <var>${dateTimeFormat('dd-MMM-yyyy', scheduledDate)}</var></p>'
          '<p>Time : <var>${dateTimeFormat('hh:mm', scheduledDate)}</var></p>'
          '<p>Subject : <var>$subject</var></p>'
          '<p>Faculty : <var>$tutorName</var></p>'
          '<p></p>'
          '<p></p>'
          '<p>Cordinator</p>'
          '<p>(<var>$course</var>)</p>'
          '<p>Live to smile digital academy</p>'
          '</body>',
      'emailList':emailList,
      'status':'Meeting Scheduled'
    });

    print('eeee');
  }

  final format = DateFormat("yyyy-MM-dd HH:mm");
  TimeOfDay time;
  DateTime date;
  TextEditingController batch;
  TextEditingController tutor;
  TextEditingController description;
  TextEditingController name;
  List<String> tutors=['select Tutor'];

  Future launchURL(String url) async {
    var uri = Uri.parse(url).toString();
    try {
      await launch(uri);
    } catch (e) {
      throw 'Could not launch $uri: $e';
    }
  }

  getTutor(List list){
    tutors.clear();

    for(var data in list){
      print(data);
      tutors.add(tutorMap[data]['name']);
    }
    if(mounted){
      setState(() {

      });
    }

  }

  //SCHEDULED CLASS
  List scheduledClasses=[];
  var lastDocSh;
  var firstDocSh;
  Map <int,DocumentSnapshot> lastDocumentsSh={};
  int pageIndexSh=0;
  int limit=10;
  getScheduledClass(){
    print('true');
    FirebaseFirestore.instance.collection('zoomClass')
        // .where('start',isEqualTo: false)
        .where('status',isEqualTo: 0)
        .orderBy('scheduled')
        .limit(limit)
        .snapshots()
        .listen((event) {
      scheduledClasses.clear();
      for(DocumentSnapshot doc in event.docs){
        scheduledClasses.add(doc.data());
      }
      lastDocSh = event.docs.last;
      lastDocumentsSh[pageIndexSh] = lastDocSh;
      firstDocSh = event.docs.first;
      print(scheduledClasses.length.toString()+'                    jjjjj');
      if(mounted){
        setState(() {

        });
      }
    });
  }
  nextSh() {
    pageIndexSh++;
    if (lastDocSh == null || pageIndexSh == 0) {

      print(lastDocSh.toString()+'nnnnnnnnnnnnnnnnnn');
      getScheduledClass();
    } else {
      FirebaseFirestore.instance.collection('zoomClass')
          // .where('start',isEqualTo: false)
          .where('status',isEqualTo: 0)
          .orderBy('scheduled')
          .startAfterDocument(lastDocSh)
          .limit(limit)
          .snapshots()
          .listen((event) {

        scheduledClasses = [];
        for (DocumentSnapshot orders in event.docs) {
          scheduledClasses.add(orders.data());
        }
        lastDocSh = event.docs.last;
        lastDocumentsSh[pageIndexSh] = lastDocSh;
        firstDocSh = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print('  next  ');
        print(scheduledClasses.length.toString()+'                mmmmmm');
        print(lastDocSh.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prevSh() {
    pageIndexSh--;
    if (firstDocSh == null || pageIndexSh == 0) {
      getScheduledClass();
    } else {
      FirebaseFirestore.instance.collection('zoomClass')
          // .where('start',isEqualTo: false)
          .where('status',isEqualTo: 0)
          .orderBy('scheduled')
          .startAfterDocument(lastDocumentsSh[pageIndexSh - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        scheduledClasses= [];
        for (DocumentSnapshot orders in event.docs) {
          scheduledClasses.add(orders.data());
        }
        lastDocSh = event.docs.last;
        lastDocumentsSh[pageIndexSh] = lastDocSh;
        firstDocSh = event.docs.first;
        print('  prev  ');
        print(scheduledClasses.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }

  //PAST SCHEDULES
  List pastSchedules=[];
  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  getPastSchedules(){
    FirebaseFirestore.instance.collection('zoomClass')
        .where('start',isEqualTo: true)
        .where('status',isEqualTo: 1)
        .orderBy('scheduled')
        .limit(limit)
        .snapshots()
        .listen((event) {
      pastSchedules=[];
      for(var students in event.docs){
        pastSchedules.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(pastSchedules.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getPastSchedules();
    } else {
      FirebaseFirestore.instance.collection('zoomClass')
          .where('start',isEqualTo: false)
          .where('status',isEqualTo: 1)
          .orderBy('scheduled')
          .limit(limit)
          .snapshots()
          .listen((event) {

        pastSchedules = [];
        for (DocumentSnapshot orders in event.docs) {
          pastSchedules.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print('  next  ');
        print(pastSchedules.length.toString()+'                mmmmmm');
        print(lastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getPastSchedules();
    } else {
      FirebaseFirestore.instance.collection('zoomClass')
          .where('start',isEqualTo: false)
          .where('status',isEqualTo: 1)
          .orderBy('scheduled')
          .limit(limit)
          .snapshots()
          .listen((event) {
        pastSchedules = [];
        for (DocumentSnapshot orders in event.docs) {
          pastSchedules.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(pastSchedules.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScheduledClass();
    getPastSchedules();
    batch=TextEditingController();
    tutor=TextEditingController();
    description=TextEditingController();
    name=TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children:[
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 30),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Add New Schedules',
                //           style: FlutterFlowTheme.bodyText1.override(
                //             fontFamily: 'Poppins',
                //             color: Colors.black,
                //             fontSize: 25,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   children: [
                //     SizedBox(width: 30,),
                //
                //     Container(
                //       width: MediaQuery.of(context).size.width*0.2,
                //       height: 60,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(
                //           color: Color(0xFFE6E6E6),
                //         ),
                //       ),
                //       child:
                //       CustomDropdown.search(
                //         hintText: 'Select Batch',hintStyle: TextStyle(color:Colors.black),
                //         items: classes,
                //         controller: batch,
                //         // excludeSelected: false,
                //         onChanged: (text){
                //
                //           tutor.clear();
                //
                //           getTutor(classMap[ClassNameToId[text]]['tutors']);
                //           setState(() {
                //
                //           });
                //
                //         },
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     Container(
                //       width: MediaQuery.of(context).size.width*0.25,
                //       height: 60,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(
                //           color: Color(0xFFE6E6E6),
                //         ),
                //       ),
                //       child:
                //       CustomDropdown.search(
                //         hintText: 'Select Tutor',hintStyle: TextStyle(color:Colors.black),
                //         items: tutors,
                //         controller: tutor,
                //         // excludeSelected: false,
                //         onChanged: (text){
                //           setState(() {
                //
                //           });
                //
                //         },
                //       ),
                //     ),
                //
                //     SizedBox(width: 10,),
                //     Expanded(
                //       child: Container(
                //         width: 330,
                //         height: 60,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius:
                //           BorderRadius.circular(8),
                //           border: Border.all(
                //             color: Color(0xFFE6E6E6),
                //           ),
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.fromLTRB(
                //               16, 0, 0, 0),
                //           child: TextFormField(
                //             controller: name,
                //             obscureText: false,
                //             decoration: InputDecoration(
                //               labelText: 'Name',
                //               labelStyle: FlutterFlowTheme
                //                   .bodyText2
                //                   .override(
                //                 fontFamily: 'Montserrat',
                //                 color: Color(0xFF8B97A2),
                //                 fontWeight: FontWeight.w500,
                //               ),
                //               hintText: 'Please Enter Name',
                //               hintStyle: FlutterFlowTheme
                //                   .bodyText2
                //                   .override(
                //                 fontFamily: 'Montserrat',
                //                 color: Color(0xFF8B97A2),
                //                 fontWeight: FontWeight.w500,
                //               ),
                //               enabledBorder:
                //               UnderlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Colors.transparent,
                //                   width: 1,
                //                 ),
                //                 borderRadius:
                //                 const BorderRadius.only(
                //                   topLeft:
                //                   Radius.circular(4.0),
                //                   topRight:
                //                   Radius.circular(4.0),
                //                 ),
                //               ),
                //               focusedBorder:
                //               UnderlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Colors.transparent,
                //                   width: 1,
                //                 ),
                //                 borderRadius:
                //                 const BorderRadius.only(
                //                   topLeft:
                //                   Radius.circular(4.0),
                //                   topRight:
                //                   Radius.circular(4.0),
                //                 ),
                //               ),
                //             ),
                //             style: FlutterFlowTheme.bodyText2
                //                 .override(
                //               fontFamily: 'Montserrat',
                //               color: Color(0xFF8B97A2),
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //
                //   ],
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           width: 330,
                //           height: 60,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius:
                //             BorderRadius.circular(8),
                //             border: Border.all(
                //               color: Color(0xFFE6E6E6),
                //             ),
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.fromLTRB(
                //                 16, 0, 0, 0),
                //             child: TextFormField(
                //               controller: description,
                //               obscureText: false,
                //               decoration: InputDecoration(
                //                 labelText: 'Description',
                //                 labelStyle: FlutterFlowTheme
                //                     .bodyText2
                //                     .override(
                //                   fontFamily: 'Montserrat',
                //                   color: Color(0xFF8B97A2),
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //                 hintText: 'Please Enter Description',
                //                 hintStyle: FlutterFlowTheme
                //                     .bodyText2
                //                     .override(
                //                   fontFamily: 'Montserrat',
                //                   color: Color(0xFF8B97A2),
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //                 enabledBorder:
                //                 UnderlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Colors.transparent,
                //                     width: 1,
                //                   ),
                //                   borderRadius:
                //                   const BorderRadius.only(
                //                     topLeft:
                //                     Radius.circular(4.0),
                //                     topRight:
                //                     Radius.circular(4.0),
                //                   ),
                //                 ),
                //                 focusedBorder:
                //                 UnderlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Colors.transparent,
                //                     width: 1,
                //                   ),
                //                   borderRadius:
                //                   const BorderRadius.only(
                //                     topLeft:
                //                     Radius.circular(4.0),
                //                     topRight:
                //                     Radius.circular(4.0),
                //                   ),
                //                 ),
                //               ),
                //               style: FlutterFlowTheme.bodyText2
                //                   .override(
                //                 fontFamily: 'Montserrat',
                //                 color: Color(0xFF8B97A2),
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //       SizedBox(width: 30,),
                //       Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(5, 10, 30, 5),
                //         child: Container(
                //           width: 300,
                //           child: DateTimeField(
                //             readOnly: true,
                //             initialValue: DateTime.now(),
                //             format: format,
                //             onShowPicker: (context, currentValue) async {
                //               date = await showDatePicker(
                //                   context: context,
                //                   firstDate: DateTime(1900),
                //                   initialDate: currentValue ?? DateTime.now(),
                //                   lastDate: DateTime(2100));
                //               if (date != null) {
                //                 time = await showTimePicker(
                //                   context: context,
                //                   initialTime:
                //                   TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                //                 );
                //
                //                 return DateTimeField.combine(date, time);
                //
                //               } else {
                //
                //                 return currentValue;
                //
                //               }
                //
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // FFButtonWidget(
                //   onPressed: () async {
                //
                //     if(batch.text!=''&&tutor.text!=''&&date!=null&&description.text!=''){
                //
                //       bool press=await alert(context, 'Schedule Class');
                //       if(press){
                //
                //         DateTime scheduledDate=DateTimeField.combine(date, time);
                //
                //         FirebaseFirestore.instance.collection('zoomClass')
                //             .add({
                //           'name':name.text,
                //           'date':DateTime.now(),
                //           'description':description.text,
                //           "scheduled":DateTimeField.combine(date, time),
                //           'batch':ClassNameToId[batch.text],
                //           'tutor':tutorNameToId[tutor.text],
                //           'course':classMap[ClassNameToId[batch.text]]['course'],
                //           'university':classMap[ClassNameToId[batch.text]]['university'],
                //           'userId':currentUserUid,
                //           'start':false,
                //           'status':0,
                //           'notes':[],
                //           'documents':[],
                //           'attendance':[],
                //
                //         }).then((value) {
                //           value.update({
                //             'zoomClsId':value.id
                //           });
                //
                //         });
                //         String universityName=UniversityIdToName[classMap[ClassNameToId[batch.text]]['university']];
                //         String courseName=CourseIdToName[classMap[ClassNameToId[batch.text]]['course']];
                //         String classId=ClassNameToId[batch.text];
                //
                //         String token='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6ImF3QWt6Vl9wVHFHN1ExS2lwZFRxbFEiLCJleHAiOjE2NjkyNzExODAsImlhdCI6MTY2ODY2NjM4Mn0.Cs1QEITe3NKXWZ4oa5R_6_biq32dJITjOU2JzzoC2dE';
                //
                //         // schedule_class(token,scheduledDate,description.text);
                //
                //         List emailList=[];
                //         for(var student in totalStudentList){
                //           if(student['classId']==classId){
                //             emailList.add(student['email']);
                //           }
                //         }
                //
                //         class_schedulesEmail(
                //             universityName,
                //             courseName,
                //             emailList,
                //             currentUserUid,
                //             currentbranchName,
                //             batch.text,
                //             scheduledDate,
                //             tutor.text,
                //             description.text,
                //         );
                //         showUploadMessage(context, 'Class Scheduled...');
                //         setState(() {
                //           description.clear();
                //           batch.clear();
                //           tutor.clear();
                //
                //         });
                //       }
                //     }else{
                //       batch.text==''?showUploadMessage(context, 'Please Choose Batch'):
                //       tutor.text==''?showUploadMessage(context, 'Please Choose Tutor'):
                //       description.text==''?showUploadMessage(context, 'Please Enter Description'):
                //       showUploadMessage(context, 'Please Choose Date');
                //     }
                //   },
                //   text: 'Add',
                //   options: FFButtonOptions(
                //     width: 100,
                //     height: 40,
                //     color: Colors.teal,
                //     textStyle: FlutterFlowTheme.subtitle2.override(
                //         fontFamily: 'Poppins',
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 11
                //     ),
                //     borderSide: BorderSide(
                //       color: Colors.transparent,
                //       width: 1,
                //     ),
                //     borderRadius: 12,
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('New Schedules',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: scheduledClasses.length==0?Center(
                      child: Text('No Data Found...',
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey)
                      )
                  )
                      : DataTable(
                    horizontalMargin: 12,
                    columns: [
                      DataColumn(
                        label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                      ),
                      DataColumn(
                        label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                      ),
                      DataColumn(
                        label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Scheduled",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Tutor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Tutor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Subject",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                    ],
                    rows: List.generate(
                      scheduledClasses.length,
                          (index) {
                        final history=scheduledClasses[index];
                         String currentIndexId=history['zoomClsId'];

                        return DataRow(
                          color: index.isOdd
                              ?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                              :MaterialStateProperty.all(Colors.blueGrey.shade50),

                          cells: [
                            DataCell(Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(dateTimeFormat('dd-MMM-yyyy', history['date'].toDate()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(ClassIdToName[history['batch']]??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(dateTimeFormat('dd-MMM-yyyy hh:mm', history['scheduled'].toDate()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(history['description'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(tutorIdToName[history['tutor']],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(history['subject'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(   Row(
                              children: [
                                // Generated code for this Button Widget...
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  icon: Icon(
                                    Icons.video_call,
                                    color:history['status']==0 && history['start']==false? Colors.teal:Colors.green,
                                    size: 25,
                                  ),
                                  // onPressed: () async {
                                  //   bool pressed=await alert(context, 'Start Class');
                                  //
                                  //   if(pressed){
                                  //     FirebaseFirestore.instance
                                  //         .collection('zoomClass')
                                  //         .doc(currentIndexId)
                                  //         .update({
                                  //       'start':true,
                                  //     });
                                  //
                                  //     launchURL('https://us06web.zoom.us/j/8402973253?pwd=R1J1V1ZteldUSFRNOWFnVzlBR1hHZz09');
                                  //     setState(() {
                                  //
                                  //     });
                                  //   }
                                  // },
                                ),
                              ],
                            ),),
                            DataCell(   Row(
                              children: [
                                // Generated code for this Button Widget...
                                FFButtonWidget(
                                  onPressed: () async {
                                    bool pressed=await alert(context, 'Class finished');

                                    if(pressed){
                                      FirebaseFirestore.instance
                                          .collection('zoomClass')
                                          .doc(currentIndexId)
                                          .update({
                                        'status':1,
                                      });

                                    }

                                  },
                                  text: 'completed',
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

                    if (pageIndexSh != 0)
                      ElevatedButton(
                        onPressed: () {
                          prevSh();
                          setState(() {

                          });
                        },
                        child: Text('Prev'),
                      ),

                    scheduledClasses.length<limit||scheduledClasses.length==0?
                    Container():
                    ElevatedButton(
                      onPressed: () {
                        nextSh();
                        setState(() {

                        });
                      },
                      child: Text('Next'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Past Schedules',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: pastSchedules.length==0?Center(
                      child: Text('No Data Found...',
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey)
                      )
                  )
                      : DataTable(
                    horizontalMargin: 12,
                    columns: [
                      DataColumn(
                        label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                      ),
                      DataColumn(
                        label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                      ),
                      DataColumn(
                        label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Scheduled",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Tutor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                      DataColumn(
                        label: Text("Subject",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                      ),
                    ],
                    rows: List.generate(
                      pastSchedules.length,
                          (index) {
                        final history=pastSchedules[index];

                        return DataRow(
                          color: index.isOdd
                              ?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                              :MaterialStateProperty.all(Colors.blueGrey.shade50),

                          cells: [
                            DataCell(Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(dateTimeFormat('dd-MMM-yyyy', history['date'].toDate()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(ClassIdToName[history['batch']]??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(dateTimeFormat('dd-MMM-yyyy hh:mm', history['scheduled'].toDate()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(history['description'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(tutorIdToName[history['tutor']],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                            DataCell(Text(history['subject'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),

                            // DataCell(Text(fileInfo.size)),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [

                    if (pageIndex != 0)
                      ElevatedButton(
                        onPressed: () {
                          prev();
                          setState(() {

                          });
                        },
                        child: Text('Prev'),
                      ),

                    pastSchedules.length<limit||pastSchedules.length==0?
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
                ),
                SizedBox(height: 20,),
              ]
            ),
          ),
        ),
      )
    );
  }
}
