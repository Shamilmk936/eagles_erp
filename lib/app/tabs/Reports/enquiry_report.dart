import 'dart:convert';
import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smile_erp/app/pages/home_page/home.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../app_widget.dart';
import '../Student/StudentSinglePageView.dart';

class EnquiryReport extends StatefulWidget {
  const EnquiryReport({Key key}) : super(key: key);

  @override
  _EnquiryReportState createState() => _EnquiryReportState();
}

class _EnquiryReportState extends State<EnquiryReport> {

  TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List totalEnq = [];
  List searchedItems=[];
  String sortValue;

  List enqList=[];
  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=15;
  getEnq() async {
    FirebaseFirestore.instance
        .collection('enquiry')
        .orderBy('date', descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {

      enqList = [];
      totalEnq = [];

      for (DocumentSnapshot orders in event.docs) {
        enqList.add(orders.data());
        totalEnq.add(orders.data());

      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if (mounted) {
        setState(() {});
      }
    });
  }
  getPendingEnq() async {
    FirebaseFirestore.instance
        .collection('enquiry')
        .where('status',isEqualTo: 0)
        .orderBy('date', descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {

      enqList = [];

      for (DocumentSnapshot orders in event.docs) {
        enqList.add(orders.data());

      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if (mounted) {
        setState(() {});
      }
      print(enqList.length.toString()+' Pending');
    });
  }
  getStudents() async {
    FirebaseFirestore.instance
        .collection('enquiry')
        .where('status',isEqualTo: 1)
        .orderBy('date', descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {

      enqList = [];

      for (DocumentSnapshot orders in event.docs) {
        enqList.add(orders.data());

      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if (mounted) {
        setState(() {});
      }
    });
  }
  getDeadEnq() async {
    FirebaseFirestore.instance
        .collection('enquiry')
        .where('status',isEqualTo: 2)
        .orderBy('date', descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {

      enqList = [];

      for (DocumentSnapshot orders in event.docs) {
        enqList.add(orders.data());

      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if (mounted) {
        setState(() {});
      }
    });
  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      if (sortValue == 'Pending Enquiries') {
        print('PENDING');
        getPendingEnq();
      } else if (sortValue == 'Students') {
        print('STUDENTS');
        getStudents();
      } else if(sortValue == 'Dead Enquiries'){
        getDeadEnq();
      }else{
        getEnq();
      }

    } else {
      FirebaseFirestore.instance
          .collection('enquiry')
          .orderBy('date', descending: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        enqList = [];
        for (DocumentSnapshot orders in event.docs) {
          enqList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print(enqList.length.toString()+'                mmmmmm');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {

       if (sortValue == 'Pending Enquiries') {
        getPendingEnq();
      } else if (sortValue == 'Students') {
        getStudents();
      } else if(sortValue == 'Dead Enquiries'){
        getDeadEnq();
      }else{
        getEnq();
      }

    } else {
      FirebaseFirestore.instance
          .collection('enquiry')
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        // paymentPendingOrdersSort = [];
        enqList = [];
        for (DocumentSnapshot orders in event.docs) {
          // paymentPendingOrdersSort.add(OrderModel.fromJson(orders.data()));
          enqList.add(orders.data());
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

  searchEnq(String search){
    enqList=[];
    print('enqList  1');
    print(enqList);
    for(var searchItem in totalEnq){

      if(searchItem['name'].toUpperCase().toString().contains(search.toUpperCase())){
        print('bbb');
        enqList.add(searchItem);
      }
    }
    print(enqList.toString());
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    if(mounted){
      setState(() {

      });
    }

  }
  Future<void> importData() async {

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['enquiry'];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri)
    );

    if(enqList.length>0){
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'Date';// dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'NAME';// dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'MOBILE';// dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'UNIVERSITY';// dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
      cell6.value = 'COURSE';// dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
      cell7.value = 'STATUS';// dynamic values support provided;
      cell7.cellStyle = cellStyle;


    }

    print(enqList.length.toString()+'                 ENQ LENGTH');

    for(int i=0;i<enqList.length;i++){

      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+2}"));
      cell1.value = i.toString(); // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+2}"));
      cell2.value = dateTimeFormat('d-MMM-y', enqList[i]['date'].toDate()); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+2}"));
      cell3.value = enqList[i]['name']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i+2}"));
      cell4.value = enqList[i]['mobile']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i+2}"));
      cell5.value = UniversityIdToName[enqList[i]['university']]?? ''; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i+2}"));
      cell6.value = CourseIdToName[enqList[i]['courses']]?? ''; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G${i+2}"));
      cell7.value = enqList[i]['status']==0?'Pending':
      enqList[i]['status']==1?'student':'Dead Enquiry'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;

      print("hereeee");
    }

    excel.setDefaultSheet('enquiry');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "${DateTime.now().toString().substring(0,10)}.xlsx")
      ..click();
  }

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    getEnq();
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
                        'Enquiry Report',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
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
                                padding:
                                EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  obscureText: false,
                                  onChanged: (text) async {
                                    enqList=[];

                                    if(text.isNotEmpty){
                                      await searchEnq(text);
                                      setState(() {

                                      });
                                    }else{
                                      await getEnq();
                                      setState(() {

                                      });
                                    }
                                    setState(() {

                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText: 'Please Enter Name',
                                    labelStyle:
                                    FlutterFlowTheme.bodyText2.override(
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
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  search.clear();
                                  getEnq();
                                  setState(() {});
                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle:
                                  FlutterFlowTheme.subtitle2.override(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: FlutterFlowDropDown(
                        initialOption: sortValue ?? 'Total Enquiries',
                        options: [
                          'Total Enquiries',
                          'Pending Enquiries',
                          'Students',
                          'Dead Enquiries'
                        ],
                        onChanged: (val) {
                          sortValue = val;

                          if (sortValue == 'Total Enquiries') {
                            getEnq();
                          } else if (sortValue == 'Pending Enquiries') {
                            getPendingEnq();
                          } else if (sortValue == 'Students') {
                            getStudents();
                          } else {
                            getDeadEnq();
                          }

                          setState(() {});
                        },
                        width: double.infinity,
                        height: 60,
                        textStyle: FlutterFlowTheme.bodyText1.override(
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
              enqList.length == 0
                  ? LottieBuilder.network(
                'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                height: 500,
              )
                  : SizedBox(
                width: double.infinity,
                child: DataTable(
                  horizontalMargin: 10,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Enquiry Id",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    DataColumn(
                      label: Text("Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    DataColumn(
                      label: Text("Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    DataColumn(
                      label: Text("Mobile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    DataColumn(
                      label: Text("Place",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    DataColumn(
                      label: Text("Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                  rows: List.generate(
                    enqList.length,
                        (index) {
                      String name = enqList[index]['name'];
                      String place = enqList[index]['place'];
                      String mobile = enqList[index]['mobile'];
                      String email = enqList[index]['email'];

                      return DataRow(
                        color: index.isOdd
                            ? MaterialStateProperty.all(
                            Colors.blueGrey.shade50.withOpacity(0.7))
                            : MaterialStateProperty.all(
                            Colors.blueGrey.shade50),
                        cells: [
                          DataCell(Text(
                            enqList[index]['enquiryId'],
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(Container(
                            width:
                            MediaQuery.of(context).size.width * 0.07,
                            child: Text(
                              dateTimeFormat('d-MMM-y',
                                  enqList[index]['date'].toDate()),
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                          DataCell(Text(
                            name,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(Text(
                            mobile,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(Text(
                            place,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(InkWell(
                            onTap: () {
                              if (enqList[index]['status'] == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudentSinglePageView(
                                              id: enqList[index]
                                              ['studentId'],
                                            )));
                              }
                            },
                            child: Text(
                              enqList[index]['status'] == 0
                                  ? 'Pending'
                                  : enqList[index]['status'] == 1
                                  ? 'Student'
                                  : 'Dead Enquiry',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: enqList[index]['status'] == 1
                                    ? Color(0xFF4B39EF)
                                    : enqList[index]['status'] == 2
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
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

                    enqList.length<limit||enqList.length==0?
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
