import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Login/login.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';

class CreateNewPopup extends StatefulWidget {
  final String studentId;
  final String univerity;
  final String course;
  final int yearIndex;
  const CreateNewPopup({Key key, this.studentId, this.univerity, this.course, this.yearIndex}) : super(key: key);

  @override
  State<CreateNewPopup> createState() => _CreateNewPopupState();
}

class _CreateNewPopupState extends State<CreateNewPopup> {

  TextEditingController admissionFee;
  TextEditingController univesityFee;
  TextEditingController convocationFee;
  TextEditingController tuitionFee;
  TextEditingController scholarship;

  List courseData=[];
  List feeList=[];
  double currentYearTotalFee;
  getUniversityFeeStrct(String selectedUniversity,String selectedCourse,int year) async {
    print('mmmm');
    DocumentSnapshot doc=await FirebaseFirestore.instance
        .collection('university')
        .doc(selectedUniversity)
        .get();
    List courseList=doc.get('courseList');
    for(var course in courseList){

      if(course['courseId']==selectedCourse){
        courseData.add(course);
        print(year);
        feeList=courseData[0]['feeList'];
        print(feeList);
      }
    }
    print(courseData);
    admissionFee.text=feeList[year]['admissionFee'].toString();
    univesityFee.text=feeList[year]['universityFee'].toString();
    convocationFee.text=feeList[year]['convactionFee'].toString();
    tuitionFee.text=feeList[year]['tuitionFee'].toString();
    currentYearTotalFee=feeList[year]['totalFee'];

    print('  ${currentYearTotalFee}   ffffffffffffffffff');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admissionFee=TextEditingController();
    univesityFee=TextEditingController();
    convocationFee=TextEditingController();
    tuitionFee=TextEditingController();
    scholarship=TextEditingController();
    getUniversityFeeStrct(widget.univerity,widget.course,widget.yearIndex);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Upgrade  Student')),
      content: Container(
        width: 600,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(height: 25,),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 330,
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
                        enabled: false,
                        controller: admissionFee,
                        decoration: InputDecoration(
                          labelText: 'Admission Fee',
                          labelStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

                          ),
                          hintText: 'Please Enter Admission Fee',
                          hintStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

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
                          fontSize: 12,

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: Container(
                    width: 330,
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
                        controller: univesityFee,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'University Fee',
                          labelStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

                          ),
                          hintText: 'Please Enter University Fee',
                          hintStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

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
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    width: 330,
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
                        controller: convocationFee,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Convocation Fee',
                          labelStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          hintText: 'Please Enter Convocation Fee',
                          hintStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

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
                          fontSize: 12,

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: Container(
                    width: 330,
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
                        controller: tuitionFee,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Tuition Fee',
                          labelStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

                          ),
                          hintText: 'Please Enter Tuition Fee',
                          hintStyle: FlutterFlowTheme
                              .bodyText2
                              .override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,

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
                          fontSize: 12,

                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      width: 330,
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
                          controller: scholarship,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Scholarship',
                            labelStyle: FlutterFlowTheme
                                .bodyText2
                                .override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,

                            ),
                            hintText: 'Please Enter Scholarship',
                            hintStyle: FlutterFlowTheme
                                .bodyText2
                                .override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,

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
                            fontSize: 12,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
            child: FFButtonWidget(
              onPressed: () async {
                if(admissionFee.text!=''&&univesityFee.text!=''&&convocationFee!=''){

                  List tuitionFeeList=[];
                  if(tuitionFee.text!=''){
                    tuitionFeeList.add({
                      'date': DateTime.now(),
                      'amount': double.tryParse(tuitionFee.text),
                      'modeOfPayment':'CASH',
                      'userId':currentUserUid
                    });
                  }

                  List fee=[];
                  fee.add({
                    'admissionFee':double.tryParse(admissionFee.text),
                    'universityFee':double.tryParse(univesityFee.text),
                    'tuitionFee':tuitionFeeList,
                    'convocationFee':double.tryParse(convocationFee.text)??0,
                    'scholarship':double.tryParse(scholarship.text)??0,
                    'currentYearTotalFee':currentYearTotalFee,
                    'date':DateTime.now(),
                  });

                  FirebaseFirestore.instance
                      .collection('candidates')
                      .doc(widget.studentId)
                      .update({
                    'feeDetails':FieldValue.arrayUnion(fee),
                    'currentYear':FieldValue.increment(1),
                  });
                  
                  showUploadMessage(context, 'Student Upgraded Successfully');
                  Navigator.pop(context);

                }else{
                  admissionFee.text==''?showUploadMessage(context, 'Please Enter Admission Fee'):
                  showUploadMessage(context, 'Please Enter University Fee');
                }

              },
              text: ' Upgrade Student',
              options: FFButtonOptions(
                width: 170,
                height: 50,
                color: Color(0xFF4B39EF),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 10,
              ),
            ),
          ),
          SizedBox(height: 25,)

        ],),),


    );
  }
}
