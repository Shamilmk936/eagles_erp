import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:smile_erp/app/pages/home_page/home.dart';
import 'package:smile_erp/backend/backend.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../Reports/admissionsSinglePage.dart';

class ClassSinglePage extends StatefulWidget {
  final String classId;
  const ClassSinglePage({Key key, this.classId,}) : super(key: key);

  @override
  State<ClassSinglePage> createState() => _ClassSinglePageState();
}

class _ClassSinglePageState extends State<ClassSinglePage> {
  TextEditingController subject;

  @override

  List<dynamic> selectedTutors;
  List students=[];
  getStudents(){

    FirebaseFirestore.instance
        .collection('candidates')
    .where('classId',isEqualTo: widget.classId)
    .snapshots().listen((event) {
      for(var student in event.docs){
        students.add(student);
      }
      setState(() {

      });
    });

  }

  bool loaded=false;
  List subjectList=[];

  void initState() {
    // TODO: implement initState
    super.initState();
    getStudents();
    subject=TextEditingController();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('class').doc(widget.classId).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        var data=snapshot.data;
        if(loaded==false){
          loaded=true;
          selectedTutors=data.get('tutors');
          subjectList=data.get('subject');
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFECF0F5),
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            title: Text(data['name'],
              style: FlutterFlowTheme.title1.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          // backgroundColor: Color(0xFFECF0F5),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Tutors',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width*0.65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                              child: MultiFilterSelect(
                                allItems: tutorList,
                                initValue: selectedTutors,
                                hintText: 'select tutors',
                                selectCallback: (List selectedValue) {
                                  selectedTutors = selectedValue;
                                  setState(() {

                                  });

                                },
                              )
                          ),
                        ),
                        SizedBox(width: 30,),
                        InkWell(
                          onTap: () async {
                            bool pressed=await alert(context, 'update Tutors');
                           if(pressed){
                             data.reference.update({
                               'tutors':selectedTutors,
                             });
                           }
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal
                            ),
                            child: Center(
                                child: Text('Update Tutor'
                                ,style: TextStyle(fontSize: 15,color: Colors.white),)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Subjects',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
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
                            controller: subject,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Subject',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              ),
                              hintText: 'Please Enter Subject',
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
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          if(subject.text!=''){
                            subjectList.add(subject.text);
                          }
                          print(subjectList);
                          subject.clear();
                          setState(() {

                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 20,
                          child: Icon(Icons.add,size: 15,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                  subjectList.length==0?
                      Container(
                        height: MediaQuery.of(context).size.width*0.1,
                        child: Center(
                            child: Text('No Data Found',style: TextStyle(fontSize: 16),)
                        ),
                      )
                  :ListView.builder(
                      shrinkWrap: true,
                      itemCount: subjectList.length,
                      itemBuilder: (context,  index){
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[350],
                                ),
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(subjectList[index]),
                                      InkWell(
                                        onTap:() async {
                                          bool pressed=await alert(context, 'Delete subject?');
                                          if(pressed){
                                            subjectList.removeAt(index);
                                            setState(() {

                                            });
                                          }
                                        },
                                          child: Icon(Icons.delete,size: 20,color: Colors.red,)
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        bool pressed=await alert(context, 'update Subjects');
                        if(pressed){
                          data.reference.update({
                            'subject':subjectList
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal
                        ),
                        child: Center(
                            child: Text('Update Subjects'
                              ,style: TextStyle(fontSize: 15,color: Colors.white),)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Student',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  students.length==0?
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
                          label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                        ),
                      ],
                      rows: List.generate(
                        students.length,
                            (index) {

                          String name=students[index]['name'];
                          String mobile=students[index]['phoneCode']+students[index]['mobile'];
                          String email=students[index]['email'];
                          String course=CourseIdToName[students[index]['course']];
                          String university=UniversityIdToName[students[index]['university']];
                          String className=ClassIdToName[students[index]['classId']];

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
                              DataCell(  Row(
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
                              ),
                              ),

                            ],
                          );
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
