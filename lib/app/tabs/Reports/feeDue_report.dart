import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import '../../../backend/backend.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';

class PaymentReport extends StatefulWidget {
  const PaymentReport({Key key}) : super(key: key);

  @override
  _PaymentReportState createState() => _PaymentReportState();
}

class _PaymentReportState extends State<PaymentReport> {

  String sortBatch;

  Timestamp datePicked1;
  DateTime today;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  List displayStudents=[];
  List allStudents=[];
  List batchStudents=[];
  SortWithBatch(String batch){
    FirebaseFirestore.instance
        .collection('candidates')
        .where('verified',isEqualTo: 1)
        .where('status',isEqualTo: 0)
        .where('classId',isEqualTo: batch)
        .orderBy('dueDate',descending: true)
        .limit(limit)
        .snapshots().listen((event) {
      batchStudents=[];
      for(var stu in event.docs){
        if(stu.get('classId')==batch){
          batchStudents.add(stu);
        }
      }
      lastDoc = batchStudents.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = batchStudents.first;
      print(batchStudents.length.toString()+'fghjk');
      setState(() {
        displayStudents=batchStudents;
      });
    });

  }

  List dateSortList=[];
  sortWithDate(Timestamp from,Timestamp to){
    print(from.toDate());
    print(to.toDate());
    FirebaseFirestore.instance
        .collection('candidates')
        .where('verified',isEqualTo: 1)
        .where('status',isEqualTo: 0)
        .where('dueDate',isGreaterThanOrEqualTo: from)
        .where('dueDate',isLessThanOrEqualTo: to)
        .orderBy('dueDate',descending: true)
    .snapshots()
    .listen((event) {
      dateSortList=[];

        dateSortList=event.docs;
        // if(stu.get('date').toDate().isAfter(from.toDate()) && stu.get('date').toDate().isBefore(to.toDate())){
        //   setState(() {
        //   });
        // }
      setState(() {
        print(dateSortList.length.toString()+'gggggggggggggggggggggggggggg');
        displayStudents=dateSortList;
      });
    });

  }

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=15;

  getStudnts(){
    FirebaseFirestore.instance
        .collection('candidates')
        .where('verified',isEqualTo: 1)
        .where('status',isEqualTo: 0)
        .orderBy('dueDate',descending: true)
        .limit(limit)
        .snapshots()
        .listen((event) {
      displayStudents=[];
      allStudents=[];
      for(var student in event.docs){
        displayStudents.add(student);
        allStudents.add(student);
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      print(displayStudents.length.toString()+'nnnnn');
      if(mounted){
        setState(() {

        });
      }
    });
  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      if(sortBatch!=null||sortBatch!='All Batches'){
        String classId=ClassNameToId[sortBatch];
        print(classId);
        SortWithBatch(classId);
      }else{
        getStudnts();
      }

    } else {
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .where('status',isEqualTo: 0)
          .orderBy('dueDate',descending: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        displayStudents = [];
        for (DocumentSnapshot orders in event.docs) {
          displayStudents.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print(displayStudents.length.toString()+'                mmmmmm');
        print(lastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      print('Vg');

      if(sortBatch!=null){
        String classId=ClassNameToId[sortBatch];
        print(classId);
        SortWithBatch(classId);
      }else{
        getStudnts();
      }

    } else {
      FirebaseFirestore.instance
          .collection('candidates')
          .where('verified',isEqualTo: 1)
          .where('status',isEqualTo: 0)
          .orderBy('dueDate',descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        displayStudents = [];
        for (DocumentSnapshot orders in event.docs) {
          displayStudents.add(orders.data());
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

  Future<void> importData() async {

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['feeDue'];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri)
    );

    if(displayStudents.length>0){
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'Due Date';// dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'Batch';// dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'STUDENT ID';// dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'NAME';// dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
      cell6.value = 'PAID';// dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
      cell7.value = 'DUE';// dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H1"));
      cell8.value = 'TOTAL';// dynamic values support provided;
      cell8.cellStyle = cellStyle;

    }

    print(displayStudents.length.toString()+'                 ENQ LENGTH');

    for(int i=0;i<displayStudents.length;i++){

      double paid=0;
      double due=0;
      double total=0;
      double scholarship=0;
      double tuitionFee=0;

      for(var data in displayStudents[i]['feeDetails']){

        for(var tu in data['tuitionFee']){
          tuitionFee+=tu['amount'];
        }
        total+=double.tryParse(data['currentYearTotalFee'].toString());
        scholarship+=double.tryParse(data['scholarship'].toString());
        paid=tuitionFee;
      }

      due=total-paid-scholarship;

      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+2}"));
      cell1.value = i.toString(); // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+2}"));
      cell2.value = dateTimeFormat('d-MMM-y', displayStudents[i]['dueDate'].toDate()); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+2}"));
      cell3.value = ClassIdToName[displayStudents[i]['classId']]; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i+2}"));
      cell4.value = displayStudents[i]['studentId']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i+2}"));
      cell5.value = displayStudents[i]['name'];// dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i+2}"));
      cell6.value = paid; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G${i+2}"));
      cell7.value = due;// dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H${i+2}"));
      cell8.value = total;// dynamic values support provided;
      cell8.cellStyle = cellStyle;

      print("hereeee");

    }

    excel.setDefaultSheet('feeDue');
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
    today=DateTime.now();
    datePicked1=Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    datePicked2=Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
    selectedDate1 = DateTime(today.year,today.month,today.day,0,0,0);
    selectedDate2 = DateTime(today.year,today.month,today.day,23,59,59);
    getStudnts();
    super.initState();
  }
  @override
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
                  children: [
                    Expanded(
                      child: Text(
                        'Fee Due Report [Batch]',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          TextButton(

                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: selectedDate1,
                                    firstDate: DateTime(1901, 1),
                                    lastDate: DateTime(2100,1)).then((value){

                                  setState(() {
                                    DateFormat("yyyy-MM-dd").format(value);
                                    datePicked1 = Timestamp.fromDate(DateTime(value.year,value.month,value.day,0,0,0));
                                    selectedDate1=value;
                                  });
                                });

                              },
                              child: Text(
                                datePicked1==null?'Choose Ending Date': datePicked1.toDate().toString().substring(0,10),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,),
                              )),
                          Text(
                            'To',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: selectedDate2,
                                    firstDate: DateTime(1901, 1),
                                    lastDate: DateTime(2100,1)).then((value){

                                  setState(() {
                                    DateFormat("yyyy-MM-dd").format(value);

                                    datePicked2 = Timestamp.fromDate(DateTime(value.year,value.month
                                        ,value.day,0,0,0));

                                    selectedDate2=value.add(Duration(hours: 23,minutes: 59,seconds: 59));
                                  });
                                });

                              },
                              child: Text(
                                datePicked2==null?'Choose Ending Date': datePicked2.toDate().toString().substring(0,10),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,),
                              )),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            icon: const FaIcon(
                              FontAwesomeIcons.search,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () async {
                              if(datePicked1!=null&&datePicked2!=null){
                                print('pressed');
                                sortWithDate(datePicked1,datePicked2);
                                print('pressed1');
                              }else{
                                datePicked1==null? showUploadMessage(context, 'Please Choose Starting Date'):
                                showUploadMessage(context, 'Please Choose Ending Date');
                              }

                            },
                          ),

                        ],
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
                              sortBatch = val;

                              if(sortBatch=='All Batches'){
                                getStudnts();
                              }else{
                                String classId=ClassNameToId[sortBatch];
                                print(classId);
                                SortWithBatch(classId);
                              }

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

              displayStudents.length==0?
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
                      label: Text("SL NO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                    ),
                    DataColumn(
                      label: Text("StudentId",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                    ),
                    DataColumn(
                      label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Due Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Year",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Paid",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Scholarship",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("Due(-scholarship)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                    DataColumn(
                      label: Text("ToTal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                    ),

                  ],
                  rows: List.generate(
                    displayStudents.length,
                        (index) {

                      double paid=0;
                      double due=0;
                      double total=0;
                      double scholarship=0;
                      double tuitionFee=0;

                      for(var data in displayStudents[index]['feeDetails']){


                        for(var tu in data['tuitionFee']){
                          tuitionFee+=tu['amount'];
                        }
                        total+=double.tryParse(data['currentYearTotalFee'].toString());
                        scholarship+=double.tryParse(data['scholarship'].toString());
                        paid=tuitionFee;
                      }

                      
                      due=total-paid-scholarship;
                   
                      String name= '${displayStudents[index]['name']} ${displayStudents[index]['lastName']}';
                      String stuId=displayStudents[index]['studentId'];
                      String batch=ClassIdToName[displayStudents[index]['classId']]??'';
                      String email=displayStudents[index]['email'];
                      int year=displayStudents[index]['currentYear']??1;
                      DateTime dueDate=displayStudents[index]['dueDate'].toDate();
                      int status=displayStudents[index]['status'];
                      return DataRow(
                        color: index.isOdd?
                        MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                            :MaterialStateProperty.all(Colors.blueGrey.shade50),

                        cells: [
                          DataCell(SelectableText((index+1).toString(),style: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),)),
                          DataCell(SelectableText(stuId,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),)),
                          DataCell(  Text(name
                              ,style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),),
                          DataCell(Container(
                            width:MediaQuery.of(context).size.width*0.05,
                            child: SelectableText(dateTimeFormat('d-MMM-y', dueDate),
                              style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: dueDate.isAfter(DateTime.now())||due==0?Colors.black:Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),),
                          )),
                          DataCell(SelectableText(batch,  style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),)),
                          DataCell(SelectableText(year==1?'First Year':year==2?'Second Year'
                            :'Third Year',
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),)),
                          DataCell(  Text(paid.toStringAsFixed(2)
                              ,style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),),
                          DataCell(  Text(scholarship.toStringAsFixed(2)
                              ,style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),),
                          DataCell(  Text(due.toStringAsFixed(2)
                              ,style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: due==0?Colors.black:Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),),
                          DataCell(  Text(total.toStringAsFixed(2)
                              ,style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),),

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


                    displayStudents.length<limit||displayStudents.length==0?
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
