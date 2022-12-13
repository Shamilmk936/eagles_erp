import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:excel/excel.dart';
import 'package:smile_erp/app/app_widget.dart';
import 'package:smile_erp/auth/auth_util.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../Login/login.dart';
import '../../../backend/backend.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../pages/home_page/home.dart';
import 'package:universal_html/html.dart' as html;

class AddExpense extends StatefulWidget {
  const AddExpense({Key key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController amount;
  TextEditingController expenseHead;
  DateTime selectedDate = DateTime.now();
  Timestamp expenseDate;

  Timestamp datePicked1;
  DateTime today;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  var expenseDoc;
  Timestamp fromDateTimeStamp;
  Timestamp toDateTimeStamp;

  getExpenses() async {
    if(selectedDate1!=null && datePicked2!=null) {
      Timestamp fromDateTimeStamp =Timestamp.fromDate(DateTime(selectedDate1.year, selectedDate1.month, selectedDate1.day));
      Timestamp toDateTimeStamp =Timestamp.fromDate(DateTime(selectedDate2.year, selectedDate2.month, selectedDate2.day));
      expenseDoc = await FirebaseFirestore.instance.collection('expense')
          .where('date', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('date', isLessThan: toDateTimeStamp)
          .get();
      setState(() {

      });
      print(expenseDoc.docs.length);
    }
  }
  getAllExpenses()async{
    var now = DateTime.now();
    var lastMidnight =Timestamp.fromDate(DateTime(now.year, now.month, now.day));
     FirebaseFirestore.instance
        .collection('expense')
        .where('date',isGreaterThanOrEqualTo: lastMidnight)
        .snapshots()
    .listen((event) {
       expenseDoc=event;
       setState(() {

       });
     });
    setState(() {

    });
    print(expenseDoc.docs.length);
  }

  Future<void> importData() async {

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['expence'];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri)
    );


    if(expenseDoc.docs.length>0){
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'DATE';// dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'PaARTICULAR';// dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'AMOUNT';// dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'COLLECTED BY';// dynamic values support provided;
      cell5.cellStyle = cellStyle;

    }

    print(expenseDoc.docs.length);

    for(int i=0;i<expenseDoc.docs.length;i++){

      var data = expenseDoc.docs;


      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+2}"));
      cell1.value = i.toString(); // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+2}"));
      cell2.value = dateTimeFormat('d-MMM-y', data[i]['date'].toDate());// dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+2}"));
      cell3.value = data[i]['particular']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i+2}"));
      cell4.value = data[i]['amount']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i+2}"));
      cell5.value =currentUserIdToName[data[i]['user']]==null?'':currentUserIdToName[data[i]['user']];// dynamic values support provided;
      cell5.cellStyle = cellStyle;


      print("hereeee");

    }

    excel.setDefaultSheet('expence');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "Expense_Report.xlsx")
      ..click();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount=TextEditingController();
    expenseHead=TextEditingController();
    today=DateTime.now();
    datePicked1=Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    datePicked2=Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
    selectedDate1 = DateTime(today.year,today.month,today.day,0,0,0);
    selectedDate2 = DateTime(today.year,today.month,today.day,23,59,59);
    getAllExpenses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Add Expense',
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
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  height: MediaQuery.of(context).size.height*0.23,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                        child: Text(
                          'Add Expenses',
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsetsDirectional.all(8),
                                child: InkWell(
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(1901, 1),
                                        lastDate: DateTime(2100,1)).then((value){

                                      setState(() {
                                        DateFormat("yyyy-MM-dd").format(value);

                                        expenseDate = Timestamp.fromDate(DateTime(value.year,value.month
                                            ,value.day,0,0,0));

                                        selectedDate=value.add(Duration(hours: 23,minutes: 59,seconds: 59));
                                      });
                                      print(expenseDate);
                                    });

                                  },
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                      child:expenseDate==null? Center(
                                        child: Text('choose Date',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                      )
                                          :Center(
                                        child: Text(expenseDate.toDate().toString().substring(0,10),),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 400,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child:
                                Center(
                                  child: CustomDropdown.search(
                                    hintText: 'Select particulars',hintStyle: TextStyle(color:Colors.black),
                                    items: expHeadList,
                                    controller: expenseHead,
                                    // excludeSelected: false,
                                    onChanged: (text){
                                      setState(() {

                                      });

                                    },

                                  ),
                                ),

                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 350,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: amount,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Amount',
                                      hintStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12

                                      ),
                                      enabledBorder:
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius:
                                        const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(4.0),
                                          topRight:
                                          Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder:
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius:
                                        const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(4.0),
                                          topRight:
                                          Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText2
                                        .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 30, 5),
                              child:  InkWell(
                                  onTap:() async {
                                    if(amount.text!=''&&expenseHead.text!=''){
                                      FirebaseFirestore.instance.collection('expense').add({
                                        'date':expenseDate==null?DateTime.now():expenseDate,
                                        'amount':double.tryParse(amount.text),
                                        'particular':expenseHead.text,
                                        'user':currentUserUid,
                                        'branchId':currentbranchId,
                                      });

                                      amount.text='';
                                      expenseHead.text='';
                                      showUploadMessage(context, 'Expense Added Successfully');
                                    }else{
                                      amount.text==''? showUploadMessage(context, 'Please Enter Amount'):
                                      showUploadMessage(context, 'Please Select particular');
                                    }


                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    height: 40,
                                    decoration:BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                        child: Text('Add',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                  )
                              ) ,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Row(
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
                        fromDateTimeStamp =Timestamp.fromDate(DateTime(selectedDate1.year, selectedDate1.month, selectedDate1.day));
                        toDateTimeStamp =Timestamp.fromDate(DateTime(selectedDate2.year, selectedDate2.month, selectedDate2.day));
                        print('pressed1');
                        getExpenses();
                      }else{
                        datePicked1==null? showUploadMessage(context, 'Please Choose Starting Date'):
                        showUploadMessage(context, 'Please Choose Ending Date');
                      }



                    },
                  ),

                ],
              ),
              expenseDoc!=null?
              Column(
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                      child: SizedBox(
                              width:
                              MediaQuery.of(context).size.width*0.7,
                              child: DataTable(
                                horizontalMargin: 10,
                                columnSpacing:20,

                                columns: [
                                  DataColumn(
                                    label: Text("S.Id ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                  ),
                                  DataColumn(
                                    label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                  ),
                                  DataColumn(
                                    label: Text("Particular",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                  ),
                                  DataColumn(
                                    label: Text("Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                  ),
                                  DataColumn(
                                    label: Text("Collected By",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                  ),


                                ],
                                rows: List.generate(
                                  expenseDoc.docs.length,
                                      (index) {
                                    DocumentSnapshot data = expenseDoc.docs[index];

                                    return DataRow(
                                      color: index.isOdd?
                                      MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                          :MaterialStateProperty.all(Colors.blueGrey.shade50),

                                      cells: [
                                        DataCell(Container(
                                          width:MediaQuery.of(context).size.width*0.05,
                                          child: SelectableText('${(index+1).toString()}',  style: FlutterFlowTheme.bodyText2.override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        )),
                                        DataCell(Text( dateTimeFormat('d-MMM-y', data['date'].toDate()),
                                          style: FlutterFlowTheme.bodyText2.override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(Container(
                                          width:MediaQuery.of(context).size.width*0.1,
                                          child: SelectableText(data['particular'],style: FlutterFlowTheme.bodyText2.override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        )),
                                        DataCell(Container(
                                          width:MediaQuery.of(context).size.width*0.1,
                                          child: SelectableText(data['amount'].toString(),style: FlutterFlowTheme.bodyText2.override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        )),
                                        DataCell(Container(
                                          width:MediaQuery.of(context).size.width*0.1,
                                          child: SelectableText(currentUserIdToName[data['user']]==null?Text(''):currentUserIdToName[data['user']].toString(),style: FlutterFlowTheme.bodyText2.override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        )),

                                      ],
                                    );
                                  },
                                ),

                      )
                            )


                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 8),
                    child: TextButton(
                        child: const Text('Generate Excel'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.lightBlue,
                          onSurface: Colors.grey,
                        ),
                        onPressed: (){
                          try{
                            importData();
                          }catch(e){
                            print(e);

                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('error'),
                                    content: Text(e.toString()),

                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text('ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });

                          }
                        }
                    ),
                  )

                ],
              )
                  :Container(),
            ],
          ),
        ),
      ),
    );
  }
}
