
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smile_erp/auth/auth_util.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:smile_erp/backend/schema/index.dart';
import 'package:smile_erp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:smile_erp/flutter_flow/flutter_flow_widgets.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:flutter/services.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multiple_select.dart';
import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../app_widget.dart';
import '../../models/enquiry_model.dart';
import '../../pages/home_page/home.dart';
import 'package:intl/intl.dart';


class AddEnquiryWidget extends StatefulWidget {
  final String name;
  final String mobile;
  final String email;
  const AddEnquiryWidget({Key key, this.name, this.mobile, this.email,}) : super(key: key);

  @override
  _AddEnquiryWidgetState createState() => _AddEnquiryWidgetState();
}

class _AddEnquiryWidgetState extends State<AddEnquiryWidget> {
  String uploadedFileUrl1='';
  String dropDownValue;
  String uploadedFileUrl2;
  TextEditingController name;
  TextEditingController place;
  TextEditingController mobile;
  TextEditingController email;
  TextEditingController course;
  TextEditingController additionalInfo;
  TextEditingController qualification;
  TextEditingController institute;
  TextEditingController university;
  DateTime dateOfBirth;
  String countryCode='IN';
  String phoneCode='+91';


  String selectedUniversity;
  String yearOfPassout;
  DateTime selectedDate = DateTime.now();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List educationDetails=[];

  List courseList=[];
  getCourses(String selectesUniversity)async{
    universityCourses=[];
    DocumentSnapshot doc= await FirebaseFirestore.instance
        .collection('university')
        .doc(selectesUniversity)
        .get();
    courseList=doc.get('courses');
    print(courseList);
    for(var item in courseList){
      universityCourses.add(CourseIdToName[item]);
    }
    print(universityCourses);
    print('Jjjjjjjjjjjjjjj');
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    place = TextEditingController();
    mobile = TextEditingController();
    additionalInfo = TextEditingController();
    qualification = TextEditingController();
    institute = TextEditingController();
    email = TextEditingController(text: '');
    course = TextEditingController();
    university = TextEditingController();

    if( widget.name!=null){
      name.text=widget.name;
    }
    if( widget.email!=null){
      email.text=widget.email;
    }
    if( widget.mobile!=null){
      mobile.text=widget.mobile;
    }


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
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Add New Enquiry',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Material(
                                color: Colors.transparent,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  // width: 950,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECF0F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                        Text('Personal Details',style: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 30, 5),
                                          child: Row(
                                            children: [
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
                                                      controller: name,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Name',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12
                                                        ),
                                                        hintText: 'Please Enter Name',
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
                                              SizedBox(width: 10,),
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
                                                      controller: place,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Place',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color:Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12

                                                        ),
                                                        hintText: 'Please Enter Place Name',
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
                                                          fontSize: 12

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              // Expanded(
                                              //   child: Container(
                                              //     color: Colors.white,
                                              //     width: 350,
                                              //     child: Padding(
                                              //       padding: EdgeInsets.fromLTRB(
                                              //           16, 0, 0, 0),
                                              //       child: TextFormField(
                                              //         inputFormatters: <TextInputFormatter>[
                                              //           LengthLimitingTextInputFormatter(10)
                                              //         ],
                                              //         autovalidateMode: AutovalidateMode.onUserInteraction,
                                              //         keyboardType: TextInputType.phone,
                                              //         validator: (email) {
                                              //           if (email.isEmpty) {
                                              //             return "Enter your phone number";
                                              //           } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                              //               .hasMatch(email)) {
                                              //             return "phone number is not valid";
                                              //           } else {
                                              //             return null;
                                              //           }
                                              //         },
                                              //         controller: mobile,
                                              //         obscureText: false,
                                              //         decoration: InputDecoration(
                                              //           labelText: 'Mobile',
                                              //           labelStyle: FlutterFlowTheme
                                              //               .bodyText2
                                              //               .override(
                                              //               fontFamily: 'Montserrat',
                                              //               color: Colors.black,
                                              //               fontWeight: FontWeight.w500,
                                              //               fontSize: 12
                                              //
                                              //           ),
                                              //           hintText: 'Please Enter Mobile No',
                                              //           hintStyle: FlutterFlowTheme
                                              //               .bodyText2
                                              //               .override(
                                              //               fontFamily: 'Montserrat',
                                              //               color: Colors.black,
                                              //               fontWeight: FontWeight.w500,
                                              //               fontSize: 12
                                              //
                                              //           ),
                                              //           enabledBorder:
                                              //           UnderlineInputBorder(
                                              //             borderSide: BorderSide(
                                              //               color: Colors.transparent,
                                              //               width: 1,
                                              //             ),
                                              //             borderRadius:
                                              //             const BorderRadius.only(
                                              //               topLeft:
                                              //               Radius.circular(4.0),
                                              //               topRight:
                                              //               Radius.circular(4.0),
                                              //             ),
                                              //           ),
                                              //           focusedBorder:
                                              //           UnderlineInputBorder(
                                              //               borderSide: BorderSide(
                                              //                 color: Colors
                                              //                     .transparent,
                                              //                 width: 1,
                                              //               ),
                                              //               borderRadius:
                                              //               BorderRadius
                                              //                   .circular(10)),
                                              //         ),
                                              //         style: FlutterFlowTheme.bodyText2
                                              //             .override(
                                              //             fontFamily: 'Montserrat',
                                              //             color: Color(0xFF8B97A2),
                                              //             fontWeight: FontWeight.w500,
                                              //             fontSize: 12
                                              //
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              Expanded(
                                                child: Container(
                                                  width: 330,
                                                  // color: Colors.white,
                                                  child: IntlPhoneField(
                                                    controller: mobile,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      labelText: 'Phone Number',
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFFE6E6E6),
                                                        ),
                                                      ),
                                                    ),
                                                    initialCountryCode:'IN',
                                                    onChanged: (phone) {

                                                      phoneCode=phone.countryCode;
                                                      countryCode=phone.countryISOCode;
                                                      log(phoneCode);
                                                      print(countryCode+'**********');

                                                      setState(() {

                                                      });

                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 30, 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: TextFormField(
                                                      controller: email,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      keyboardType: TextInputType.emailAddress,
                                                      validator: (email) {
                                                        if (email.isEmpty) {
                                                          return "Enter your email";
                                                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                                            .hasMatch(email)) {
                                                          return "Email not valid";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        labelText: 'Email',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12
                                                        ),
                                                        hintText: 'Please Enter Email',
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
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    final DateTime selected = await showDatePicker(
                                                      fieldHintText: 'dd/mm/yyyy',
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime(2050),
                                                    );
                                                    if (selected != null && selected != dateOfBirth) {
                                                      setState(() {
                                                        dateOfBirth = DateTime(selected.year,selected.month,selected.day,0,0,0);
                                                      });
                                                    }
                                                  },
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
                                                          16, 10, 0, 0),
                                                      child: Container(
                                                        child:Center(child:dateOfBirth==null?
                                                        Text('please choose')
                                                            :Text("${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}",
                                                          style: FlutterFlowTheme
                                                              .bodyText2
                                                              .override(
                                                              fontFamily: 'Montserrat',
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12

                                                          ), ),

                                                        ),

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 30, 5),
                                          child: Row(
                                            children: [


                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width*0.2,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          color: Color(0xFFE6E6E6),
                                                        ),
                                                      ),
                                                      child:
                                                      CustomDropdown.search(
                                                        hintText: 'Select Education Board',hintStyle: TextStyle(color:Colors.black),
                                                        items: universityList,
                                                        controller: university,
                                                        // excludeSelected: false,
                                                        onChanged: (text){
                                                          setState(() {
                                                            selectedUniversity=UniversityNameToId[university.text];
                                                            print(selectedUniversity);
                                                            print('mmmmmmm');
                                                            getCourses(selectedUniversity);
                                                          });
                                                        },
                                                      )
                                                  ),
                                                ),
                                              ),
                                              selectedUniversity!=null && universityCourses.isNotEmpty?
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.2,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(
                                                        color: Color(0xFFE6E6E6),
                                                      ),
                                                    ),
                                                    child:
                                                    CustomDropdown.search(
                                                      hintText: 'Select course',hintStyle: TextStyle(color:Colors.black),
                                                      items: universityCourses,
                                                      controller: course,
                                                      // excludeSelected: false,
                                                      onChanged: (text){
                                                        setState(() {

                                                        });

                                                      },
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  :Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

                              Material(
                                color: Colors.transparent,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  // width: 950,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECF0F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                        Text('Educational Details',style: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 30, 5),
                                          child: Row(
                                            children: [
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
                                                      controller: qualification,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Qualification',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12
                                                        ),
                                                        hintText: 'Please Enter Qualification',
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
                                              SizedBox(width: 10,),

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
                                                      controller: institute,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'institute',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12

                                                        ),
                                                        hintText: 'Please Enter institute name',
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
                                                          fontSize: 12

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),

                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    showDatePicker(
                                                        context: context,
                                                        initialDate: selectedDate,
                                                        firstDate: DateTime(1901, 1),
                                                        lastDate: DateTime(2300,1)).then((value){

                                                      setState(() {
                                                        DateFormat("d-MM-y").format(value);

                                                        Timestamp passoutYear = Timestamp.fromDate(DateTime(value.year,value.month
                                                            ,value.day,0,0,0));

                                                        yearOfPassout=dateTimeFormat('d-MMM-y',passoutYear.toDate());
                                                        print(yearOfPassout);
                                                        selectedDate=value;
                                                      });
                                                    });
                                                  },
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
                                                    child: yearOfPassout==null||yearOfPassout==''?
                                                    Center(
                                                      child: Center(
                                                        child: Text('choose pass out year',style:FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12
                                                        ),),
                                                      ),
                                                    )
                                                        :Center(
                                                      child: Text(yearOfPassout),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),


                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                                child: FFButtonWidget(
                                                  onPressed: () {

                                                    if(qualification.text!=''&&yearOfPassout!=''){
                                                      educationDetails.add({
                                                        'qualification':qualification.text,
                                                        'institute':institute.text,
                                                        'year':yearOfPassout,
                                                      });
                                                      setState(() {

                                                        qualification.text='';
                                                        institute.text='';
                                                        yearOfPassout='';


                                                      });

                                                    }else{
                                                      qualification.text==''?showUploadMessage(context, 'Please Enter Qualification'):
                                                      institute.text==''?showUploadMessage(context, 'Please Enter Marks'):
                                                      showUploadMessage(context, 'Please Enter Year');
                                                    }

                                                  },
                                                  text: 'Add',
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 40,
                                                    color: Colors.teal,
                                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    elevation: 2,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 50,
                                                  ),
                                                ),
                                              )


                                            ],
                                          ),

                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child:educationDetails.length==0?Center(child: Text('No Details Added...',style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13
                                          ),)): DataTable(
                                            horizontalMargin: 12,
                                            columns: [
                                              DataColumn(
                                                label: Text("Sl No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                              ),
                                              DataColumn(
                                                label: Text("Qualification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              DataColumn(
                                                label: Text("Institute",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              DataColumn(
                                                label: Text("Year",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              DataColumn(
                                                label: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                            ],
                                            rows: List.generate(
                                              educationDetails.length,
                                                  (index) {
                                                final history=educationDetails[index];

                                                return DataRow(
                                                  color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                                  cells: [
                                                    DataCell(Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                                    DataCell(Text(history['qualification'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                                    DataCell(Text(history['institute'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                                    DataCell(Text(history['year'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                                    DataCell(   Row(
                                                      children: [
                                                        // Generated code for this Button Widget...
                                                        FlutterFlowIconButton(
                                                          borderColor: Colors.transparent,
                                                          borderRadius: 30,
                                                          borderWidth: 1,
                                                          buttonSize: 50,
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Color(0xFFEE0000),
                                                            size: 25,
                                                          ),
                                                          onPressed: () async {

                                                            bool pressed=await alert(context, 'Do you want Delete');

                                                            if(pressed){
                                                              educationDetails.removeAt(index);


                                                              showUploadMessage(context, 'Details Deleted...');
                                                              setState(() {

                                                              });

                                                            }

                                                          },
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
                                        SizedBox(height: 10,),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 30, 5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 440,
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
                                                      controller: additionalInfo,
                                                      obscureText: false,
                                                      maxLines: 4,
                                                      decoration: InputDecoration(
                                                        labelText: 'Additional Info',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12
                                                        ),
                                                        hintText: 'Please Enter Additional Information',
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
                                              SizedBox(width: 10,),
                                            ],
                                          ),

                                        ),

                                        Align(
                                          alignment: Alignment(0.95, 0),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: ()  async {

                                                if(name.text!=''&&place.text!=''&&mobile.text!=''&&course.text!='' &&university.text!=''){

                                                  bool proceed = await alert(context, 'You want to Add this Enquiry?');

                                                  if (proceed) {
                                                    DocumentSnapshot doc =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('settings')
                                                        .doc(currentbranchId)
                                                        .get();
                                                    FirebaseFirestore.instance
                                                        .collection('settings')
                                                        .doc(currentbranchId)
                                                        .update({
                                                      'enquiryId': FieldValue.increment(1),

                                                    });
                                                    int enquiryId = doc['enquiryId'];
                                                    print(doc['enquiryId']);
                                                    enquiryId++;

                                                    Map  details=  Enquiry(
                                                        status: 0,
                                                        date: DateTime.now(),
                                                        name:name.text,
                                                        place:place.text,
                                                        mobile:mobile.text,
                                                        email:email.text,
                                                        dob:dateOfBirth,
                                                        additionalInfo:additionalInfo.text??"",
                                                        educationalDetails:educationDetails,
                                                        courses:CourseNameToId[course.text],
                                                        university:UniversityNameToId[university.text],
                                                        userId:currentUserUid,
                                                        branchId:currentbranchId,
                                                        userEmail:currentUserEmail,
                                                        search:setSearchParam(name.text+" "+mobile.text),
                                                        check:false,
                                                        enquiryId:'E'+currentbranchShortName+enquiryId.toString(),
                                                        phoneCode: phoneCode,
                                                        countryCode: countryCode
                                                    ).toJson();


                                                    FirebaseFirestore.instance
                                                        .collection('enquiry')
                                                        .doc('E'+currentbranchShortName+enquiryId.toString())
                                                        .set(details);

                                                    showUploadMessage(context, 'New Enquiry Added...');

                                                    setState(() {
                                                      name.text='';
                                                      place.text='';
                                                      email.text='';
                                                      mobile.text='';
                                                      additionalInfo.text='';
                                                      educationDetails=[];
                                                      course.text='';
                                                      university.text='';

                                                    });
                                                  }

                                                }else{
                                                  name.text==''?showUploadMessage(context, 'Please Enter Name'):
                                                  place.text==''?showUploadMessage(context, 'Please Enter Place'):
                                                  course.text==''?showUploadMessage(context, 'Please Select Course'):
                                                  university.text==''?showUploadMessage(context, 'Please Select University'):
                                                  showUploadMessage(context, 'Please Enter Mobile Number');
                                                }

                                              },
                                              text: 'Add Enquiry',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 50,
                                                color: Colors.teal,
                                                textStyle:
                                                FlutterFlowTheme.subtitle2.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                elevation: 2,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

