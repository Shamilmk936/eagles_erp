
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiple_select/multiple_select.dart';
import '../../../backend/schema/index.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../../main.dart';

class AddCourseWidget extends StatefulWidget {
  const AddCourseWidget({Key key}) : super(key: key);

  @override
  _AddCourseWidgetState createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends State<AddCourseWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool edit=false;
  TextEditingController name;
  TextEditingController search;
  TextEditingController eName;
  String currentId='';

  String courseType;
  String eCourseType;
  List<Item> intakes = [];
  List selectedIntakes = [];


  getIntakes() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("intakes")
        .where('available',isEqualTo: true)
        .get();
    for (var doc in data1.docs) {
      intakes.add(Item.build(
        value: doc.id,
        display: dateTimeFormat('MMM yyyy', doc['intake'].toDate()),
        content: dateTimeFormat('MMM yyyy', doc['intake'].toDate()),
      ));

    }
  }


  @override
  void initState() {
    super.initState();
    getIntakes();
    search = TextEditingController();
    eName = TextEditingController();
    name = TextEditingController();
  }
  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            edit==true?
            //clear button & heading
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'EDIT COURSE',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FFButtonWidget(
                      onPressed: ()  {
                        edit=false;


                        setState(() {
                          eName.text='';
                          // eCourseType=null;

                        });
                      },
                      text: 'Clear ',
                      options: FFButtonOptions(
                        width: 90,
                        height: 40,
                        color: Colors.red,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),


                ],
              ),
            ):
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'ADD COURSE',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            edit==true?
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,

                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                16, 0, 0, 0),
                            child: TextFormField(
                              controller: eName,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Course Name',
                                labelStyle: FlutterFlowTheme
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Please Enter Course Name',
                                hintStyle: FlutterFlowTheme
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11
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
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: FlutterFlowDropDown(
                          initialOption: eCourseType??'UG',
                          options: ['UG','PG','Plus Two','SSLC'].toList(),
                          onChanged: (val) => setState(() => eCourseType = val),
                          width: 180,
                          height: 50,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          hintText: 'Please select Programme',
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.black,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                      SizedBox(width: 20,),
                      FFButtonWidget(
                        onPressed: () async {

                          if(eName.text!=''&&eCourseType!=null){

                            bool proceed = await alert(context,
                                'You want to Update This Course?');
                            if(proceed){
                              FirebaseFirestore.instance.collection('course')
                                  .doc(currentId)
                                  .update({
                                'name':eName.text,
                                'courseType':eCourseType,
                                'search':setSearchParam(eName.text),
                                'delete':false,

                              });
                              showUploadMessage(context, 'Course Updated...');
                              setState(() {
                                edit=false;
                                eName.text='';

                              });
                            }

                          }else{
                            eName.text==''?showUploadMessage(context, 'Please Enter Name'):
                            showUploadMessage(context, 'Please Select course type');
                          }
                        },
                        text: 'Update',
                        options: FFButtonOptions(
                          width: 100,
                          height: 50,
                          color: Colors.teal,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ):
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 330,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                16, 0, 0, 0),
                            child: TextFormField(
                              controller: name,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Course Name',
                                labelStyle: FlutterFlowTheme
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Please Enter Course Name',
                                hintStyle: FlutterFlowTheme
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
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
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12

                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: FlutterFlowDropDown(
                          initialOption: courseType??'UG',
                          options: ['UG','PG','Plus Two','SSLC']
                              .toList(),
                          onChanged: (val) => setState(() => courseType = val),
                          width: 180,
                          height: 50,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          hintText: 'Please select course type',
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.black,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                      SizedBox(width: 20,),
                      FFButtonWidget(
                        onPressed: () async {

                          if(name.text!=''&&courseType!=null){

                            bool proceed = await alert(context,
                                'You want to Add This Course?');
                            if(proceed){
                              FirebaseFirestore.instance.collection('course')
                                  .add({
                                'name':name.text,
                                'courseType':courseType,
                                'search':setSearchParam(name.text),
                                'delete':false,
                              });
                              showUploadMessage(context, 'Course Added Successfully...');
                              setState(() {
                                edit=false;
                                name.text='';
                                selectedIntakes.clear();

                              });
                            }

                          }else{
                            name.text==''?showUploadMessage(context, 'Please Enter Name'):
                            showUploadMessage(context, 'Please Select Course Type');
                          }
                        },
                        text: 'Add',
                        options: FFButtonOptions(
                          width: 80,
                          height: 50,
                          color: myColors,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),

                    ],
                  ),

                ),
              ],
            ),

            //search&clear section
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
                                onChanged: (text){
                                  setState(() {

                                  });
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Search',
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

            search.text==''?
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('course')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    var data=snapshot.data.docs;
                    print(data.length);
                    return Container(
                      width:  MediaQuery.of(context).size.width*0.75,

                      height: MediaQuery.of(context).size.height*0.9,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [

                            DataColumn(label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("Course Type",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("",style: TextStyle(fontWeight: FontWeight.bold)),),
                          ],
                          rows: List<DataRow>.generate(
                            data.length,
                                (index) {

                              String name=data[index]['name'];
                              String duration=data[index]['courseType'];

                              return DataRow(
                                color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
                                cells: [
                                  DataCell(Text(name,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                                  DataCell(Text(duration??'',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))),
                                  DataCell(
                                    Row(
                                      children: [
                                        FFButtonWidget(
                                        onPressed: ()  {
                                          print(duration);

                                          setState(() {
                                            edit=true;
                                            currentId=data[index].id;
                                            eName.text=name;
                                            eCourseType=duration;
                                          });
                                          print(courseType);
                                          print('PASS ');
                                        },
                                        text: 'View',
                                        options: FFButtonOptions(
                                          width: 70,
                                          height: 30,
                                          color: Colors.white,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
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
                                  DataCell(
                                    Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          bool proceed = await alert(context,
                                              'You want to Delete This Course?');
                                          if(proceed){

                                            // data[index].reference.delete();

                                            showUploadMessage(context, 'Course Deleted...');
                                            setState(() {
                                              edit=false;

                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Color(0xFFEE0000),
                                          size: 25,
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
                    );
                  }
              ),
            ):
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('course')
                      .where('delete',isEqualTo: false)
                      .where('search',arrayContains: search.text.toUpperCase())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    var data=snapshot.data.docs;
                    print(data.length);
                    return Container(
                      width:  MediaQuery.of(context).size.width*0.75,


                      height: MediaQuery.of(context).size.height*0.9,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [

                            DataColumn(label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("Course Type",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),),
                            DataColumn(label: Text("",style: TextStyle(fontWeight: FontWeight.bold)),),
                          ],
                          rows: List<DataRow>.generate(
                            data.length,
                                (index) {

                              String name=data[index]['name'];
                              String typeOfCourse=data[index]['courseType'];

                              return DataRow(
                                color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                cells: [
                                  DataCell(Text(name,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                                  DataCell(Text(typeOfCourse,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))),
                                  DataCell(
                                    Row(
                                      children: [
                                        FFButtonWidget(
                                        onPressed: ()  {
                                          setState(() {
                                            edit=true;
                                            currentId=data[index].id;
                                            eName.text=name;
                                            eCourseType=typeOfCourse;

                                          });


                                        },
                                        text: 'View',
                                        options: FFButtonOptions(
                                          width: 70,
                                          height: 30,
                                          color: Colors.white,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
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
                                  DataCell(
                                    Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          bool proceed = await alert(context,
                                              'You want to Delete This Course?');
                                          if(proceed){
                                            data[index].reference.update({
                                              'delete':true
                                            });
                                            showUploadMessage(context, 'Course Deleted...');
                                            setState(() {
                                              edit=false;

                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Color(0xFFEE0000),
                                          size: 25,
                                        ),
                                      ),

                                    ],
                                  ),
                                  ),

                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
