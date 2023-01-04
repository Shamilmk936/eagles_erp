import 'dart:developer';
// import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:smile_erp/backend/backend.dart';
import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../models/enquiry_model.dart';
import '../../pages/home_page/home.dart';

class RegistrationFormWidget extends StatefulWidget {

  final String name;
  final String careOf;
  final String careOfNo;
  final String eId;
  final String email;
  final String mobile;
  final String place;
  final DateTime dob;
  final String additionalInfo;
  final List educationalDetails;
  final String universityId;
  final String selectedBranch;
  final String courses;
  final String phnCode;
  final String cntyCode;

  const RegistrationFormWidget({Key key,
    this.name,
    this.email,
    this.mobile,
    this.place,
    this.dob,
    this.additionalInfo,
    this.educationalDetails,
    this.eId, this.universityId,
    this.careOf,
    this.careOfNo,
    this.selectedBranch,
    this.courses,
    this.phnCode,
    this.cntyCode
  }) : super(key: key);

  @override
  _RegistrationFormWidgetState createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController place;
  TextEditingController address;
  TextEditingController university;
  TextEditingController course;
  TextEditingController classControlller;
  TextEditingController intakeCtlr;

  TextEditingController admissionFee;
  TextEditingController universityFee;
  TextEditingController tuitionFee;
  TextEditingController convacationFee;
  TextEditingController scholarship;

  String phoneCode='+91';
  String countryCode='IN';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List Ug=['Signature','SSLC','Plus two','Aadhaar/Passport'];
  List Pg=['Signature','SSLC','Plus two','Aadhaar/Passport','Degree certificate','Degree marksheet'];
  List SSLC=['Signature','8 th marksheet/self attested certificate','Aadhaar/Passport'];
  List plusTwo=['Signature','SSLC','Aadhaar/Passport'];


  List courseList=[];
  String selectedUniversity;
  getCourses(String selectedUniversity)async{

    universityCourses=[];
    DocumentSnapshot doc= await FirebaseFirestore.instance
        .collection('university')
        .doc(selectedUniversity)
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

  List<String> classList=[];
  String selectedCourse;
  String selectedClass;
  String selectedIntake;
  String currentYear;
  getClass(String selectedUniversity,String selectedCourse){
    print('  CLASS FUNCTION   ');
    print(CourseIdToType[selectedCourse]);
    FirebaseFirestore.instance
        .collection('class')
        .where('university',isEqualTo: selectedUniversity)
        .where('course',isEqualTo: selectedCourse)
        .where('available',isEqualTo: true)
        .snapshots()
        .listen((event) {
      classList=[];
      for(var item in event.docs){
        classList.add(item.get('name'));
        ClassIdToName[item.id]=item.get('name');
        ClassNameToId[item.get('name')]=item.id;
      }
      print(classList);
      setState(() {

      });
    });

    if(CourseIdToType[selectedCourse]=='PG'){
      uploadDocument=Pg;
    }else if(CourseIdToType[selectedCourse]=='UG'){
      uploadDocument=Ug;
    }else if(CourseIdToType[selectedCourse]=='SSLC'){
      uploadDocument=SSLC;
    }else{
      uploadDocument=plusTwo;
    }

    setState(() {

    });

  }

  List courseData=[];
  List feeList=[];
  int courseDuration;
  double currentYearTotalFee;
  getUniversityFeeStrct(String selectedUniversity,String selectedCourse) async {
    DocumentSnapshot doc=await FirebaseFirestore.instance
        .collection('university')
        .doc(selectedUniversity)
        .get();
    List courseList=doc.get('courseList');
    for(var course in courseList){
      courseDuration=int.tryParse(course['duration']);

      if(course['courseId']==selectedCourse){
        courseData.add(course);
        feeList=courseData[0]['feeList'];
      }
    }
    print(courseData);
    admissionFee.text=feeList[0]['admissionFee'].toString();
    universityFee.text=feeList[0]['universityFee'].toString();
    convacationFee.text=feeList[0]['convactionFee'].toString();
    tuitionFee.text=feeList[0]['tuitionFee'].toString();
    currentYearTotalFee=feeList[0]['totalFee'];

    print('  ${currentYearTotalFee}   ffffffffffffffffff');
  }


  DateTime dob;
  DateTime selectedDate = DateTime.now();

  Map documents={};
  String uploadedFileUrl='';

  bool radioSelected1 = true;
  bool cash=false;
  bool bank=false;
  String radioval='';

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

  void paymentSuccessEmail(
      String paymentMode,
      String course,
      String intake,
      List emailList,
      String amount,
      String name,
      ) async {

    FirebaseFirestore.instance.collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body>'
          '<p>Hi <var>$name</var></p>'
          '<p>Your payment of <var>$amount</var> towards <var>$paymentMode</var> for <var>$course</var> of the academic year <var>$intake</var> with Live To Smile Digital Academy is successfully received. </p>'
          '<p></p>'
          '<p></p>'
          '<p>Cordinator</p>'
          '<p>(<var>$course</var>)</p>'
          '<p>Live to smile digital academy</p>'
          '</body>',
      'emailList':emailList,
      'status':'payment success'
    });

    print('eeee');
  }

  void register_student(
      String course,
      String intake,
      List emailList,
      String name
      ) async {

    FirebaseFirestore.instance
        .collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body>'
          '<p>Hi <var>$name</var></p>'
          '<p>Your admission for <var>$course</var> for the academic year <var>$intake</var> with Live To Smile Digital Academy is successfully registered.</p>'
          '<p>Follow the stpes to continue :</p>'
          '<p>1. Click the link provided below and install Live To Smile Application</p>'
          '<p>2. Click on Sign up using email/continue with Apple</p>'
          '<p>3. Choose the same email ID used for registration</p>'
          '<p></p>'
          '<p>playStore Link</p>'
          '<p>https://play.google.com/store/apps/details?id=com.firstlogicmetalab.smile_student</p>'
          '<p></p>'
          '<p>Lets do it together.</p>'
          '<p>Coordinator-<var>$course</var></p>'
          '<p></p>'
          '</body>',
      'emailList':emailList,
      'status':'Registration successful'
    });

    print('eeee');
  }

  @override
  void initState() {
    super.initState();
    dob=widget.dob;
    firstName = TextEditingController(text: widget.name);
    lastName = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    mobile = TextEditingController(text: widget.mobile);
    place = TextEditingController(text: widget.place);
    address = TextEditingController();
    university = TextEditingController();
    course = TextEditingController();
    classControlller = TextEditingController();
    intakeCtlr = TextEditingController();

    admissionFee = TextEditingController();
    universityFee = TextEditingController();
    tuitionFee = TextEditingController();
    convacationFee = TextEditingController();
    scholarship = TextEditingController();
    if(widget.phnCode!=''&&widget.phnCode!=null){
      phoneCode=widget.phnCode;
    }
    if(widget.cntyCode!=''&&widget.cntyCode!=null){
      countryCode=widget.cntyCode;
    }


  }

  PlatformFile pickFile;
  UploadTask uploadTask;
  Future selectFile(String name)async{

    final result = await FilePicker.platform.pickFiles();
    if(result==null)
      return;

    pickFile=result.files.first;

    String ext=pickFile.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...',showLoading: true);

    uploadFileToFireBase(name,fileBytes,ext);

    setState(() {

    });

  }
  List uploadDocument=[];
  Map data={};
  Future uploadFileToFireBase(String name, fileBytes,String ext) async {

    uploadTask= FirebaseStorage.instance.ref('uploads/${DateTime.now().toString().substring(0,10)}-$name.$ext').putData(fileBytes);
    final snapshot= await  uploadTask.whenComplete((){});
    final urlDownlod = await  snapshot.ref.getDownloadURL();

    data.addAll({'$name':urlDownlod,});
    print(data);
    print('        SUCCESS           ');

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {

    });
  }

  QuerySnapshot doc;
  checkEmail(String emailId) async {
    doc=await FirebaseFirestore.instance
        .collection('candidates')
        .where('email',isEqualTo: emailId)
        .get();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F8),
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Student Registration Form',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body:Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    10, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.black,
                        size: 35,
                      ),
                      onPressed: () async {
                        final selectedMedia =
                        await selectMedia(
                          mediaSource:
                          MediaSource.photoGallery,
                        );
                        if (selectedMedia != null &&
                            validateFileFormat(
                                selectedMedia.storagePath,
                                context)) {
                          showUploadMessage(
                              context, 'Uploading file...',
                              showLoading: true);

                          final metadata = SettableMetadata(
                            contentType: 'image/jpeg',
                            customMetadata: {
                              'picked-file-path':
                              selectedMedia.storagePath
                            },
                          );
                          print(metadata.contentType);
                          final uploadSnap =
                          await FirebaseStorage
                              .instance
                              .ref()
                              .child(
                              DateTime.now()
                                  .toLocal()
                                  .toString()
                                  .substring(0, 10))
                              .child(
                              DateTime.now()
                                  .toLocal()
                                  .toString()
                                  .substring(10, 17))
                              .putData(
                              selectedMedia.bytes,
                              metadata);
                          final downloadUrl = await uploadSnap
                              .ref
                              .getDownloadURL();
                          // final downloadUrl = await uploadData(
                          //     selectedMedia.storagePath, selectedMedia.bytes);
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar();
                          if (downloadUrl != null) {
                            setState(() => uploadedFileUrl =
                                downloadUrl);
                            showUploadMessage(
                                context, 'Success!');
                          } else {
                            showUploadMessage(context,
                                'Failed to upload media');
                            return;
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 5),
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
                            controller: firstName,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter First Name',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            controller: lastName,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Last Name',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),

                    Expanded(
                      child: Container(
                        width: 330,
                        // color: Colors.white,
                        child: IntlPhoneField(
                          controller: mobile,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE6E6E6),),
                            ),
                          ),
                          initialCountryCode: countryCode,
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
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
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
                            controller: email,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email.isEmpty) {
                                return "Enter your email";
                              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(email)) {
                                return "Email not valid";
                              } else if(doc.docs.isNotEmpty){
                                return "Email already registered with us";
                              }else {
                                return null;
                              }
                            },
                            obscureText: false,
                            onChanged: (text){
                              checkEmail(text);
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Email Address',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            controller: place,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'place',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter place',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
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
                          if (selected != null && selected != dob) {
                            setState(() {
                              dob = DateTime(selected.year,selected.month,selected.day,0,0,0);
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
                              child:Center(child:dob==null?
                              Text('please choose date of birth')
                                  :Text("${dob.day}/${dob.month}/${dob.year}",
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
                  ],
                ),
              ),
              SizedBox(width: 30,),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:Color(0xFFE6E6E6)
                          ),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDropdown.search(
                            hintText: 'Select Education Board',hintStyle: TextStyle(color:Colors.black),
                            items: universityList,
                            controller: university,
                            onChanged: (text){
                              setState(() {
                                selectedUniversity=UniversityNameToId[university.text];
                                print(selectedUniversity);
                                course.text='';
                                selectedCourse;
                                selectedClass;
                                courseList=[];
                                classList=[];
                                getCourses(selectedUniversity);
                                setState(() {

                                });

                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    selectedUniversity!=null&& universityCourses.isNotEmpty?
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:Color(0xFFE6E6E6)
                          ),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDropdown.search(
                            hintText: 'Select Course',hintStyle: TextStyle(color:Colors.black),
                            items: universityCourses,
                            controller: course,
                            onChanged: (text){
                              selectedCourse=CourseNameToId[course.text];
                              getClass(selectedUniversity, selectedCourse);
                              getUniversityFeeStrct(selectedUniversity, selectedCourse);
                              setState(() {

                              });
                            },
                          ),
                        ),
                      ),
                    )
                        :Container(),

                    SizedBox(width: 30,),

                    selectedUniversity!=null&& universityCourses.isNotEmpty
                        && selectedCourse!=null&& courseList.isNotEmpty &&classList.isNotEmpty?
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:Color(0xFFE6E6E6)
                          ),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDropdown.search(
                            hintText: 'Select batch',hintStyle: TextStyle(color:Colors.black),
                            items: classList,
                            controller: classControlller,
                            // excludeSelected: false,
                            onChanged: (text){
                              selectedClass=ClassNameToId[classControlller.text];
                              setState(() {

                              });
                            },
                          ),
                        ),
                      ),
                    )
                        :Container(),

                    SizedBox(width: 30,),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:Color(0xFFE6E6E6)
                          ),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDropdown.search(
                            hintText: 'Select InTake',hintStyle: TextStyle(color:Colors.black),
                            items: inTakes,
                            controller: intakeCtlr,
                            onChanged: (text){
                              setState(() {
                                selectedIntake=InTakeNameToId[intakeCtlr.text];
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),

                    CourseIdToType[selectedCourse]!='SSLC'?
                    FlutterFlowDropDown(
                      initialOption: currentYear??'First Year',
                      options: CourseIdToType[selectedCourse]=='PG'||CourseIdToType[selectedCourse]=='Plus Two'?
                      ['First Year', 'Second Year'].toList():
                    CourseIdToType[selectedCourse]=='UG'?
                    ['First Year', 'Second Year','Third Year'].toList():
                    ['First Year'].toList(),
                      onChanged: (val) => setState(() => currentYear = val),
                      width: 180,
                      height: 50,
                      textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold
                      ),
                      hintText: 'Please select current Year',
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Colors.black,
                      borderWidth: 0,
                      borderRadius: 0,
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
                    )
                  :Container(),

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
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            controller: address,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'address',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter address',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30,),

              selectedCourse!=null?
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Documents',
                      style: FlutterFlowTheme.title2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),)
                  ],
                ),
              )
              :Container(),

              selectedCourse!=null?
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                child:DataTable(
                  horizontalMargin: 10,
                  columnSpacing: 20,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Document Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label:  Text(
                        "upload",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),

                  ],
                  rows: List.generate(
                    uploadDocument.length,
                        (index) {
                      var docName = uploadDocument[index];
                      print(data.keys.toList());


                      return DataRow(
                        color: index.isOdd
                            ? MaterialStateProperty.all(Colors
                            .blueGrey.shade50
                            .withOpacity(0.7))
                            : MaterialStateProperty.all(
                            Colors.blueGrey.shade50),
                        cells: [
                          DataCell(SelectableText(
                            docName,
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell( Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: FFButtonWidget(
                              onPressed: ()  async {

                                  bool pressed=await alert(context, 'please upload ${docName}');
                                  if(pressed){
                                    selectFile(docName.toUpperCase());
                                    setState(() {

                                    });
                                  }

                              },
                              text: data.keys.toList().contains(docName.toString().toUpperCase())?'Edit':'Upload'
                              ,options: FFButtonOptions(
                                width: 100,
                                height: 40,
                                color: data.keys.toList().contains(docName.toString().toUpperCase())? Color(0xFF4B39EF):Colors.teal,
                                textStyle: FlutterFlowTheme
                                    .subtitle2
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
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
                          )),

                        ],
                      );
                    },
                  ),
                ),
              )
              :Container(),

              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Payment',
                      style: FlutterFlowTheme.title2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),)
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bank'),
                  SizedBox(width: 20,),
                  Radio(
                    activeColor: Colors.yellow,
                    fillColor: MaterialStateProperty.all(Colors.black),
                    overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                    focusColor: Colors.green,
                    value: bank,
                    onChanged: (value) {
                      setState(() {
                        value=true;
                        bank=value;
                        cash=false;
                        radioval='Bank';
                        print(radioval);
                        radioSelected1=value;
                      });
                    },

                    groupValue: radioSelected1,
                  ),
                  SizedBox(width: 40,),
                  Text('Cash'),
                  SizedBox(width: 20,),
                  Radio(
                    activeColor: Colors.yellow,
                    fillColor: MaterialStateProperty.all(Colors.black),
                    overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                    focusColor: Colors.green,
                    value: cash,
                    onChanged: (value) {
                      value=true;

                      setState(() {
                        radioval='Cash';
                        print(radioval);
                        cash = value;
                        bank=false;
                        radioSelected1=value;
                      });
                    },

                    groupValue: radioSelected1,
                  ),
                ],
              ),

              Padding(
                  padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                child:  Row(
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
                            enabled: false,
                            controller: admissionFee,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Admission Fee',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              ),
                              hintText: 'Please Enter Admission Fee',
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
                            enabled: false,
                            controller: universityFee,
                            decoration: InputDecoration(
                              labelText: 'University Fee',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color:Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12

                              ),
                              hintText: 'Please Enter University Fee',
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
                            enabled: false,
                            controller: convacationFee,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Convocation Fee',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color:Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12

                              ),
                              hintText: 'Please Enter Convocation Fee',
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
                            controller: tuitionFee,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Tuition Fee',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color:Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12

                              ),
                              hintText: 'Please Enter Tuition Fee',
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
                            controller: scholarship,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Scholarship',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color:Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12

                              ),
                              hintText: 'Please Enter Scholarship',
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
                  ],
                ),
              ),

              //FINISH
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {

                    print(phoneCode);

                    if(firstName.text!=''&&lastName.text!=''&&mobile.text!=''&&email.text!=''&&
                        dob!=''&& address.text!=''&&place.text!=''&&selectedClass!=''&&selectedIntake!=''
                        &&selectedClass!=null&&selectedClass!=''&& admissionFee.text!=''&&universityFee!=''
                        &&data.length==uploadDocument.length&& doc.docs.isEmpty){

                      bool pressed= await alert(context, 'Register As Student...');
                      if(pressed){

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
                          'studentId': FieldValue.increment(1),
                          'enquiryId': FieldValue.increment(1),
                        });
                        int studentId = doc.get('studentId');
                        int enquiryNo=doc.get('enquiryId');
                        studentId++;
                        enquiryNo++;


                        double ad=double.tryParse(admissionFee.text)??0;
                        double un=double.tryParse(universityFee.text)??0;
                        double tu=double.tryParse(tuitionFee.text)??0;
                        double cn=double.tryParse(convacationFee.text)??0;
                        List tuitionFeeList=[];
                          tuitionFeeList.add({
                            'date': DateTime.now(),
                            'amount': un+ad +tu+cn,
                            'modeOfPayment':radioval,
                            'userId':currentUserUid,
                            'paymentId':''
                          });


                        List paymentList=[];
                        paymentList.add({
                          'admissionFee':ad,
                          'universityFee':un,
                          'tuitionFee':tuitionFeeList,
                          'convocationFee':cn,
                          'scholarship':double.tryParse(scholarship.text)??0,
                          'currentYearTotalFee':currentYearTotalFee
                        });

                        List list =[
                          {
                            'name':'Personal Details',
                            'completed':false,
                          },
                          {
                            'name':'Fee Details',
                            'completed':false,
                          },
                          {
                            'name':'Classes',
                            'completed':false,
                          },
                          {
                            'name':'Documents',
                            'completed':false,
                          },
                        ];
                        var date = new DateTime.now();
                        FirebaseFirestore.instance.collection('candidates')
                            .doc(currentbranchShortName+studentId.toString())
                            .set({
                          'enquiryId': widget.eId??'E$currentbranchShortName$enquiryNo',
                          'form':list,
                          'date':DateTime.now(),
                          'status':0,
                          'name':firstName.text,
                          'lastName':lastName.text,
                          'mobile':mobile.text,
                          'countryCode':countryCode,
                          'phoneCode':phoneCode,
                          'email':email.text,
                          'dob':dob,
                          'place':place.text,
                          'educationalDetails':widget.educationalDetails??[],
                          'address':address.text,
                          'gender':'',
                          'branchId':currentbranchId,
                          'userId':currentUserUid,
                          'currentStatus':'Registered',
                          'search':setSearchParam(firstName.text+' '+mobile.text),
                          'photo':uploadedFileUrl,
                          'studentId':currentbranchShortName+studentId.toString(),
                          'discount':0.0,
                          'dueDate': DateTime(date.year, date.month+3, date.day),
                          'classId':selectedClass,
                          'inTake':selectedIntake,
                          'course':selectedCourse,
                          'university':selectedUniversity,
                          'documents':data,
                          'currentYear':currentYear=='First Year'?1
                              :currentYear=='Second Year'?2
                            :currentYear=='Third Year'?3:1,
                          'courseDuration':courseDuration,
                          'feeDetails':paymentList,
                          'verified':0,
                          'active':true,
                        }).then((value) {

                          if(widget.eId!=null){
                            FirebaseFirestore.instance.collection('enquiry').doc(widget.eId).update({
                              'status':1,
                              'studentId':currentbranchShortName+studentId.toString(),
                            });
                          }else{
                            print(enquiryNo.toString()+'vgggg');
                            Map  details=  Enquiry(
                                status: 1,
                                date: DateTime.now(),
                                name:'${firstName.text} ${lastName.text}',
                                place:place.text,
                                mobile:mobile.text,
                                email:email.text,
                                dob:dob,
                                additionalInfo:"",
                                educationalDetails:[],
                                courses:CourseNameToId[course.text],
                                university:UniversityNameToId[university.text],
                                userId:currentUserUid,
                                branchId:currentbranchId,
                                userEmail:currentUserEmail,
                                search:setSearchParam(firstName.text+" "+mobile.text),
                                check:false,
                                enquiryId:'E'+currentbranchShortName+enquiryNo.toString(),
                                phoneCode: phoneCode,
                                countryCode: countryCode
                            ).toJson();

                            FirebaseFirestore.instance
                                .collection('enquiry')
                                .doc('E'+currentbranchShortName+enquiryNo.toString())
                                .set(details);
                          }

                          List StudentList=[];
                          StudentList.add(currentbranchShortName+studentId.toString());

                          FirebaseFirestore.instance.collection('class')
                              .doc(selectedClass)
                              .update({
                            'students':FieldValue.arrayUnion(StudentList),
                          });

                        });
                        showUploadMessage(context, 'New Student Registered...');

                        Navigator.pop(context);

                        double paidAmount=double.tryParse(admissionFee.text)+double.tryParse(universityFee.text)
                        +double.tryParse(convacationFee.text)+double.tryParse(tuitionFee.text);
                        List emailList=[];
                        emailList.add(email.text);
                         paymentSuccessEmail(
                             radioval,
                            course.text,
                             intakeCtlr.text,
                             emailList,
                             paidAmount.toStringAsFixed(2),
                           '${firstName.text} ${lastName.text}'
                            );

                        register_student(
                            course.text,
                            intakeCtlr.text,
                             emailList,
                            '${firstName.text} ${lastName.text}'
                        );

                      }

                    }else{
                      firstName.text==''?showUploadMessage(context, 'Please Enter First Name'):
                      lastName.text==''?showUploadMessage(context, 'Plase Enter Last Place'):
                      mobile.text==''?showUploadMessage(context, 'Please Enter Mobile Number'):
                      email.text==''?showUploadMessage(context, 'Please Enter Email'):
                      selectedClass==null?showUploadMessage(context, 'Please select Batch'):
                      selectedIntake==''?showUploadMessage(context, 'Please select intake'):
                      selectedUniversity==''?showUploadMessage(context, 'Please select university'):
                      dob==null?showUploadMessage(context, 'Please select date of birth'):
                      address.text==''?showUploadMessage(context, 'Please Enter Address'):
                      place.text==''?showUploadMessage(context, 'Please Enter Place'):
                      radioval==''?showUploadMessage(context, 'Please select payment method'):
                      data.length!=uploadDocument.length?showUploadMessage(context, 'Please upload all documents'):
                      showUploadMessage(context, 'Email already registered with us');
                    }

                  },
                  text: 'Register As Student',
                  options: FFButtonOptions(
                    width: 200,
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
            ],
          ),
        ),
      ),
    );
  }
}
