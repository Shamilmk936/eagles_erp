import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smile_erp/app/pages/home_page/home.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'admissionsSinglePage.dart';

class AdmissionReport extends StatefulWidget {
  const AdmissionReport({Key key}) : super(key: key);

  @override
  _AdmissionReportState createState() => _AdmissionReportState();
}

class _AdmissionReportState extends State<AdmissionReport> {

  int status=4;

  sortWithStatusAndBatch(){
    if(sortBatch=='All Batches'&&status==4){
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .orderBy('date',descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {

        students=[];
        for(var student in event.docs){
          students.add(student);
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print(students.length.toString()+'nnnnn');
        if(mounted){
          setState(() {

          });
        }
      });
    }else if(status==4&&sortBatch!='All Batches'){
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .where('classId',isEqualTo: ClassNameToId[sortBatch])
          .orderBy('date',descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {

        students=[];
        for(var student in event.docs){
          students.add(student);
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print(students.length.toString()+'nnnnn');
        if(mounted){
          setState(() {

          });
        }
      });
    }else if(status!=4&&sortBatch=='All Batches'){
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .where('status',isEqualTo: status)
          .orderBy('date',descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {

        students=[];
        for(var student in event.docs){
          students.add(student);
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print(students.length.toString()+'nnnnn');
        if(mounted){
          setState(() {

          });
        }
      });
    }else if(status!=4&&sortBatch!='All Batches'){
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .where('status',isEqualTo: status)
          .where('classId',isEqualTo: ClassNameToId[sortBatch])
          .orderBy('date',descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {

        students=[];
        for(var student in event.docs){
          students.add(student);
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print(students.length.toString()+'nnnnn');
        if(mounted){
          setState(() {

          });
        }
      });
    }
    if(mounted){
      setState(() {

      });
    }
  }

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=15;
  // getStudnts(){
  //   FirebaseFirestore.instance
  //       .collection('candidates')
  //       .where('verified',isEqualTo: 1)
  //       .orderBy('date',descending: true)
  //       .limit(limit)
  //       .snapshots()
  //       .listen((event) {
  //
  //     students=[];
  //     for(var student in event.docs){
  //       students.add(student);
  //     }
  //     lastDoc = event.docs.last;
  //     lastDocuments[pageIndex] = lastDoc;
  //     firstDoc = event.docs.first;
  //     print(students.length.toString()+'nnnnn');
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  // }
  next() {
    pageIndex++;
    print(lastDoc);
    print(pageIndex);
    print('pageIndex');
    if (lastDoc == null || pageIndex == 0) {

      print('next');
      print('$lastDoc   $pageIndex           nnnnnnnnnnnnnnnn');
      // if(sortBatch==null||sortBatch=='All Batches'){
      //   sortWithStatusAndBatch();
      // }else {
      //   String classId=ClassNameToId[sortBatch];
      //   print(classId);
      //   SortWithBatch(classId);
      // }

      sortWithStatusAndBatch();
    } else {
      print('next 2');
      if(sortBatch=='All Batches'&&status==4){
        FirebaseFirestore.instance
            .collection('candidates')
            .where('verified',isEqualTo: 1)
            .orderBy('date',descending: true)
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots()
            .listen((event) {

          students=[];
          for(var student in event.docs){
            students.add(student);
          }
          lastDoc = event.docs.last;
          lastDocuments[pageIndex] = lastDoc;
          firstDoc = event.docs.first;
          print(students.length.toString()+'nnnnn');
          if(mounted){
            setState(() {

            });
          }
        });
      }else if(status==4&&sortBatch!='All Batches'){
        FirebaseFirestore.instance
            .collection('candidates')
            .where('verified',isEqualTo: 1)
            .where('classId',isEqualTo: ClassNameToId[sortBatch])
            .orderBy('date',descending: true)
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots()
            .listen((event) {

          students=[];
          for(var student in event.docs){
            students.add(student);
          }
          lastDoc = event.docs.last;
          lastDocuments[pageIndex] = lastDoc;
          firstDoc = event.docs.first;
          print(students.length.toString()+'nnnnn');
          if(mounted){
            setState(() {

            });
          }
        });
      }else if(status!=4&&sortBatch=='All Batches'){
        FirebaseFirestore.instance
            .collection('candidates')
            .where('verified',isEqualTo: 1)
            .where('status',isEqualTo: status)
            .orderBy('date',descending: true)
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots()
            .listen((event) {

          students=[];
          for(var student in event.docs){
            students.add(student);
          }
          lastDoc = event.docs.last;
          lastDocuments[pageIndex] = lastDoc;
          firstDoc = event.docs.first;
          print(students.length.toString()+'nnnnn');
          if(mounted){
            setState(() {

            });
          }
        });
      }else if(status!=4&&sortBatch!='All Batches'){
        FirebaseFirestore.instance
            .collection('candidates')
            .where('verified',isEqualTo: 1)
            .where('status',isEqualTo: status)
            .where('classId',isEqualTo: ClassNameToId[sortBatch])
            .orderBy('date',descending: true)
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots()
            .listen((event) {

          students=[];
          for(var student in event.docs){
            students.add(student);
          }
          lastDoc = event.docs.last;
          lastDocuments[pageIndex] = lastDoc;
          firstDoc = event.docs.first;
          print(students.length.toString()+'nnnnn');
          if(mounted){
            setState(() {

            });
          }
        });
      }
      FirebaseFirestore.instance
          .collection('candidates')
          .orderBy('date',descending: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        students = [];
        for (DocumentSnapshot orders in event.docs) {
          students.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print(students.length.toString()+'                mmmmmm');
        print(lastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      print('$lastDoc   $pageIndex           pppppppppppp');


      // if(sortBatch==null||sortBatch=='All Batches'){
      //   sortWithStatusAndBatch();
      // }else {
      //   // String classId=ClassNameToId[sortBatch];
      //   // print(classId);
      //   // SortWithBatch(classId);
      // }
      sortWithStatusAndBatch();

    } else {
      FirebaseFirestore.instance
          .collection('candidates')
          .orderBy('date',descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        students = [];
        for (DocumentSnapshot orders in event.docs) {
          students.add(orders.data());
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

  String sortValue='Total Students';
  String sortCourse;
  List students=[];

  // getcompletedStudnts(){
  //   if(sortBatch=='All Batches'){
  //     FirebaseFirestore.instance
  //         .collection('candidates')
  //         .where('status',isEqualTo: 1)
  //         .where('verified',isEqualTo: 1)
  //         .orderBy('date',descending: true)
  //         .limit(limit)
  //         .snapshots()
  //         .listen((event) {
  //       students=[];
  //       for(var student in event.docs){
  //         students.add(student);
  //       }
  //       lastDoc = event.docs.last;
  //       lastDocuments[pageIndex] = lastDoc;
  //       firstDoc = event.docs.first;
  //       print(students.length.toString()+'nnnnn');
  //       if(mounted){
  //         setState(() {
  //
  //         });
  //       }
  //     });
  //   }
  //   else{
  //     FirebaseFirestore.instance
  //         .collection('candidates')
  //         .where('status', isEqualTo: 1)
  //         .where('verified', isEqualTo: 1)
  //         .where('classId', isEqualTo: ClassNameToId[sortBatch])
  //         .orderBy('date', descending: true)
  //         .limit(limit)
  //         .snapshots()
  //         .listen((event) {
  //       students = [];
  //       for (var student in event.docs) {
  //         students.add(student);
  //       }
  //       lastDoc = event.docs.last;
  //       lastDocuments[pageIndex] = lastDoc;
  //       firstDoc = event.docs.first;
  //       print(students.length.toString() + 'nnnnn');
  //       if (mounted) {
  //         setState(() {});
  //       }
  //     });
  //   }
  // }
  // getrunningStudnts(){
  //   FirebaseFirestore.instance
  //       .collection('candidates')
  //       .where('status',isEqualTo: 0)
  //       .where('verified',isEqualTo: 1)
  //       .orderBy('date',descending: true)
  //       .limit(limit)
  //       .snapshots()
  //       .listen((event) {
  //     students=[];
  //     for(var student in event.docs){
  //       students.add(student);
  //     }
  //     lastDoc = event.docs.last;
  //     lastDocuments[pageIndex] = lastDoc;
  //     firstDoc = event.docs.first;
  //     print(students.length.toString()+'nnnnn');
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  // }
  // getdropOutStudnts(){
  //   FirebaseFirestore.instance
  //       .collection('candidates')
  //       .where('status',isEqualTo: 2)
  //       .where('verified',isEqualTo: 1)
  //       .orderBy('date',descending: true)
  //       .limit(limit)
  //       .snapshots()
  //       .listen((event) {
  //     students=[];
  //     for(var student in event.docs){
  //       students.add(student);
  //     }
  //     lastDoc = event.docs.last;
  //     lastDocuments[pageIndex] = lastDoc;
  //     firstDoc = event.docs.first;
  //     print(students.length.toString()+'nnnnn');
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  // }


  String sortBatch='All Batches';
  List batchStudents=[];
  SortWithBatch(String batch){
    if(sortValue=='Completed'){

      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified', isEqualTo: 1)
          .where('status', isEqualTo: 1)
          .where('classId', isEqualTo: batch)
          .orderBy('date', descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {
        batchStudents = [];
        for (var stu in event.docs) {
          if (stu.get('classId') == batch) {
            batchStudents.add(stu);
          }
        }
        lastDoc = batchStudents.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = batchStudents.first;
        print(batchStudents.length.toString() + 'fghjk');
        setState(() {
          students = batchStudents;
        });
      });
    }
    else{
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified', isEqualTo: 1)
          .where('status', isEqualTo: 0)
          .where('classId', isEqualTo: batch)
          .orderBy('date', descending: true)
          .limit(limit)
          .snapshots()
          .listen((event) {
        batchStudents = [];
        for (var stu in event.docs) {
          if (stu.get('classId') == batch) {
            batchStudents.add(stu);
          }
        }
        lastDoc = batchStudents.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = batchStudents.first;
        print(batchStudents.length.toString() + 'fghjk');
        setState(() {
          students = batchStudents;
        });
      });
    }
  }

  Future<void> importData() async {

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Due Report'];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri)
    );

    if(students.length>0){
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'STUDENT ID';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'DATE';// dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'NAME';// dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'MOBILE';// dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'EMAIL';// dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
      cell6.value = 'BATCH';// dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
      cell7.value = 'STATUS';// dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H1"));
      cell8.value = 'Document';// dynamic values support provided;
      cell8.cellStyle = cellStyle;

    }

    print(students.length.toString()+'             STU LENGTH');

    for(int i=0;i<students.length;i++){

      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+2}"));
      cell1.value =students[i]['studentId']; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+2}"));
      cell2.value = dateTimeFormat('d-MMM-y', students[i]['date'].toDate()); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+2}"));
      cell3.value = students[i]['name']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i+2}"));
      cell4.value = students[i]['mobile']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i+2}"));
      cell5.value = students[i]['email'];
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i+2}"));
      cell6.value = ClassIdToName[students[i]['classId']];
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G${i+2}"));
      cell7.value = students[i]['status']==0?'Registered':
      students[i]['status']==1?'Completed':'Drop Out'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H${i+2}"));
      cell8.value = students[i]['documents'];
      cell8.cellStyle = cellStyle;


      print("hereeee");

    }

    excel.setDefaultSheet('Due Report');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "${DateTime.now().toString().substring(0,10)}.xlsx")
      ..click();
  }

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(students.length);
    sortWithStatusAndBatch();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'Course Wise Report',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:60,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: MediaQuery.of(context).size.width*0.2,
                        child: FlutterFlowDropDown(
                          initialOption: sortBatch??classes[0],
                          options: classes,
                          onChanged: (val) {
                            print(val);
                            setState(() {
                              // getcompletedStudnts();
                              sortBatch = val;
                              // String classId=ClassNameToId[sortBatch];
                              // print(classId);
                              // SortWithBatch(classId);
                              sortWithStatusAndBatch();
                            });

                          },
                          width: double.infinity,
                          height: 60,
                          textStyle:
                          FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Select User',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF57636C),
                            size: 15,
                          ),
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Color(0xFFB2B4B7),
                          borderWidth: 1,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:60,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: MediaQuery.of(context).size.width*0.2,
                        child: FlutterFlowDropDown(
                            initialOption: sortValue??'Total Students',
                          options: ['Total Students','Completed','Drop Out','Running Students'],
                          onChanged: (val) {
                            setState(() {
                              sortValue = val;
                             if(sortValue=='Total Students'){
                               status=4;
                               setState(() {

                               });
                               sortWithStatusAndBatch();
                             }else if(sortValue=='Completed'){
                               status=1;
                               setState(() {

                               });
                              // getcompletedStudnts();
                              // String classId=ClassNameToId[sortBatch];
                              // print(classId);
                              // SortWithBatch(classId);
                               sortWithStatusAndBatch();
                             }else if(sortValue=='Drop Out'){
                               status=2;
                               setState(() {

                               });
                               // getdropOutStudnts();
                               sortWithStatusAndBatch();
                             }else{
                               status=0;
                               setState(() {

                               });
                               sortWithStatusAndBatch();
                               // getrunningStudnts();
                             }
                            });
                            setState(() {

                            });
                          },
                          width: double.infinity,
                          height: 60,
                          textStyle:
                          FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Select User',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF57636C),
                            size: 15,
                          ),
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Color(0xFFB2B4B7),
                          borderWidth: 1,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        try{
                          importData();
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.teal,
                        ),
                        child: Center(
                            child: Text('Generate Exel',
                              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),

        students.length==0?
                    LottieBuilder.network('https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',height: 500,):
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
                            label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                          ),
                          DataColumn(
                            label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                          ),
                          DataColumn(
                            label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                          ),
                        ],
                        rows: List.generate(
                          students.length,
                              (index) {

                            String name= '${students[index]['name']} ${students[index]['lastName']}';
                            String place=students[index]['place']??'';
                            String mobile=students[index]['phoneCode']+students[index]['mobile'];
                            String email=students[index]['email'];


                            return DataRow(
                              color: index.isOdd?
                              MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                  :MaterialStateProperty.all(Colors.blueGrey.shade50),


                              cells: [
                                DataCell(Container(
                                  width:MediaQuery.of(context).size.width*0.05,
                                  child: SelectableText(students[index]['studentId'],  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                )),
                                DataCell(Container(
                                  width:MediaQuery.of(context).size.width*0.06,
                                  child: SelectableText(dateTimeFormat('d-MMM-y', students[index]['date'].toDate()),
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
                                DataCell(SelectableText(ClassIdToName[students[index]['classId']]??'',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ))),
                                DataCell(  Text(students[index]['status']==0?'Registered':
                                students[index]['status']==1?'Completed':'Drop Out'

                                    ,style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: students[index]['status']==0?Colors.black
                                      :students[index]['status']==1?Colors.green
                                      :Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                )),),
                                DataCell(   Row(
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () {

                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdmissionsSinglePage(
                                          id: students[index].id,
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

                  if (pageIndex != 0)
                    ElevatedButton(
                      onPressed: () {
                        prev();
                      },
                      child: Text('Prev'),
                    ),


                  students.length<limit||students.length==0?
                  Container():
                  ElevatedButton(
                    onPressed: () {
                      next();
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
