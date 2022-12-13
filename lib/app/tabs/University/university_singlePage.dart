import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smile_erp/backend/backend.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';


class UniversitySinglePage extends StatefulWidget {
  final String id;
  const UniversitySinglePage({Key key, this.id,}) : super(key: key);

  @override
  State<UniversitySinglePage> createState() => _UniversitySinglePageState();
}

class _UniversitySinglePageState extends State<UniversitySinglePage> {



  List universityCourses=[];
  List universityCourses1=[];

  List tabs=[
    'Details',
    'Courses',
  ];
  List coursesList=[];
  List eCoursesList=[];
  bool available=true;
  int courseMapIndex=0;
  Map selectedCourse={};
  int selectedIndex=0;

  //DETAILS
  TextEditingController firstName;

  TextEditingController lastName;
  TextEditingController email;

  //COURSES
  String duration='First Year';
  TextEditingController addmissionFee;
  TextEditingController tutionFee;
  TextEditingController universityFee;
  TextEditingController convacationFee;
  TextEditingController totalFee;
  TextEditingController courseDuration;
  TextEditingController search;
  TextEditingController course;
  TextEditingController eligibility;
  String courseType='Years';

  //COURSE EDIT
  String eDuration;
  TextEditingController eAddmissionFee;
  TextEditingController eTutionFee;
  TextEditingController eUniversityFee;
  TextEditingController eConvacationFee;
  TextEditingController eTotalFee;
  TextEditingController eSearch;
  TextEditingController eCourse;


  bool loaded=false;
  String editCourseName;
  int slectedFeeIndex;

  double totalAmt=0;
  double eTotalAmt=0;
  void searchName(String query) {
    universityCourses.clear();

    print('New : '+universityCourses.length.toString());


    final name = universityCourses1.where((course) {
      final courseName = course['name'].toString().toLowerCase();
      final input =query.toLowerCase();

      return courseName.contains(input);
    }).toList();

    setState(() {
      universityCourses=name;
      print('second : '+universityCourses.length.toString());
    });

  }
  bool edit=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUniversity();

    //DETAILS
    firstName=TextEditingController();
    lastName=TextEditingController();
    email=TextEditingController();

    //COURSE
    // duration=TextEditingController();
    addmissionFee=TextEditingController();
    tutionFee=TextEditingController();
    universityFee=TextEditingController();
    convacationFee=TextEditingController();
    totalFee=TextEditingController();
    courseDuration=TextEditingController();
    search=TextEditingController();
    course=TextEditingController();
    eligibility=TextEditingController();

    //COURSE EDIT
    // eDuration=TextEditingController();f
    eAddmissionFee=TextEditingController();
    eTutionFee=TextEditingController();
    eUniversityFee=TextEditingController();
    eConvacationFee=TextEditingController();
    eTotalFee=TextEditingController();
    eSearch=TextEditingController();
    eCourse=TextEditingController();

  }

  List<String> eligibilityList=[
    'ANY DEGREE',
    '8TH CERTIFICATE/SELF ATTESTED DOC',
    'SSLC',
    'PLUS TWO',
  ];

  DocumentSnapshot university;
  List CoursesOffered=[];


  getUniversity(){

    FirebaseFirestore.instance.collection('university')
        .doc(widget.id).snapshots()
        .listen((event) {

      universityCourses=[];
      university=event;
      CoursesOffered=university['courses'];

      if(loaded==false){
        loaded=true;
        universityCourses1.clear();
        for(var data in university['courseList']){
          universityCourses1.add({
            'courseId':data['courseId'],
            'duration':data['duration'],
            'eligibility':data['eligibility'],
            'available':data['available'],
            'feeList':data['feeList'],
            'totalFee':data['totalFee'],
          });
          print(data);
          print('ggggggggg');
        }
        universityCourses.addAll(universityCourses1);
        loaded=false;
      }

      if(mounted){
            setState(() {

            });
          }
    });
  }

  getTotal(){
    if(universityFee.text!=''&&tutionFee.text!=''){
      double ad=double.tryParse(addmissionFee.text.toString())??0;
      double un=double.tryParse(universityFee.text.toString());
      double tu=double.tryParse(tutionFee.text.toString());
      double ca=double.tryParse(convacationFee.text.toString())??0;

      totalFee.text=(ad+un+tu+ca).toStringAsFixed(2);

    }
  }

  getEditTotal(){
    if(eUniversityFee.text!=''&&eTutionFee.text!=''){
      double ead=double.tryParse(eAddmissionFee.text.toString())??0;
      double eun=double.tryParse(eUniversityFee.text.toString());
      double etu=double.tryParse(eTutionFee.text.toString());
      double eca=double.tryParse(eConvacationFee.text.toString())??0;

      eTotalFee.text=(ead+eun+etu+eca).toStringAsFixed(2);

    }
  }



  @override
  Widget build(BuildContext context) {
    getTotal();
    getEditTotal();
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFECF0F5),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xFFF1F4F8),
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),

                              SingleChildScrollView(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(tabs.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: (){
                                            selectedIndex=index;

                                            setState(() {

                                            });
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color:selectedIndex==index?Colors.teal: Color(0xFFF1F4F8),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x3B000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  4, 4, 4, 4),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [


                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0, 8, 0, 0),
                                                    child: Text(
                                                      tabs[index],
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: selectedIndex==index?Colors.white:Color(0xFF090F13),
                                                        fontSize: 9,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              selectedIndex==0?
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: Stack(
                      alignment: AlignmentDirectional(0, 1),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: CachedNetworkImage(
                            imageUrl:
                            university.get('banner')==''?university.get('logo'):university.get('banner'),
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.fill,
                          ),
                        ),

                        Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color(0x801D2429),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 8, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 95,
                                                height: 75,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: university.get('logo'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        university.get('name'),
                                                        style: FlutterFlowTheme
                                                            .title2
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor: Colors.transparent,
                                                        borderRadius: 30,
                                                        borderWidth: 0,
                                                        buttonSize: 50,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.userEdit,
                                                          color: Colors.white,
                                                          size: 22,
                                                        ),
                                                        onPressed: () {

                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        university.get('email'),
                                                        style: FlutterFlowTheme
                                                            .subtitle2
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFF31BFAE),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              icon: FaIcon(
                                                FontAwesomeIcons.twitter,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              onPressed: () {
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              icon: FaIcon(
                                                FontAwesomeIcons.linkedinIn,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              onPressed: () {
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 0,
                                              buttonSize: 50,
                                              icon: FaIcon(
                                                FontAwesomeIcons.dribbble,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              onPressed: () {
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Courses Offered',
                      style: FlutterFlowTheme
                        .subtitle2
                        .override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: CoursesOffered.length,
                        itemBuilder: (buildContext,int index){
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.1,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Center(
                                  child: Text(CourseIdToName[CoursesOffered[index]],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF4B39EF)
                                    ),
                                  )
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              )

                  :
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      edit==false?
                      Material(
                        color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Course Details',style: FlutterFlowTheme
                                      .bodyText2
                                      .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    SizedBox(width: 50,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.3,
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
                                        items: courses,
                                        controller: course,
                                        // excludeSelected: false,
                                        onChanged: (text){
                                          setState(() {

                                          });

                                        },
                                      ),
                                    ),
                                    SizedBox(width: 20,),

                                    Container(
                                      width: 150,
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
                                          controller: courseDuration,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Duration',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                            ),
                                            hintText: 'Please Enter Course Duration',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
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
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    FlutterFlowDropDown(
                                      initialOption: courseType??'Years',
                                      options: ['Months', 'Years']
                                          .toList(),
                                      onChanged: (val) => setState(() => courseType = val),
                                      width: 180,
                                      height: 50,
                                      textStyle: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold
                                      ),
                                      hintText: 'Please select Duration',
                                      fillColor: Colors.white,
                                      elevation: 2,
                                      borderColor: Colors.black,
                                      borderWidth: 0,
                                      borderRadius: 0,
                                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                    SizedBox(width: 20,),

                                    Container(
                                      width: MediaQuery.of(context).size.width*0.2,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x4D101213),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: CustomDropdown.search(
                                        hintText: 'Eligibility',
                                        items: eligibilityList,
                                        controller: eligibility,
                                        excludeSelected: false,
                                        onChanged: (text){
                                          setState(() {

                                          });

                                        },

                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                                  child: Row(
                                    children: [
                                      FlutterFlowDropDown(
                                        initialOption: duration??'First Year',
                                        options: ['First Year', 'Second Year','Third Year']
                                            .toList(),
                                        onChanged: (val) => setState(() => duration = val),
                                        width: 180,
                                        height: 50,
                                        textStyle: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold
                                        ),
                                        hintText: 'Please select Duration',
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: Colors.black,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     width: 330,
                                      //     height: 60,
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius:
                                      //       BorderRadius.circular(8),
                                      //       border: Border.all(
                                      //         color: Color(0xFFE6E6E6),
                                      //       ),
                                      //     ),
                                      //     child: Padding(
                                      //       padding: EdgeInsets.fromLTRB(
                                      //           16, 0, 0, 0),
                                      //       child: TextFormField(
                                      //         controller: duration,
                                      //         obscureText: false,
                                      //         decoration: InputDecoration(
                                      //           labelText: 'Duration',
                                      //           labelStyle: FlutterFlowTheme
                                      //               .bodyText2
                                      //               .override(
                                      //             fontFamily: 'Montserrat',
                                      //             color: Color(0xFF8B97A2),
                                      //             fontWeight: FontWeight.w500,
                                      //           ),
                                      //           hintText: 'Please Enter Duration',
                                      //           hintStyle: FlutterFlowTheme
                                      //               .bodyText2
                                      //               .override(
                                      //             fontFamily: 'Montserrat',
                                      //             color: Color(0xFF8B97A2),
                                      //             fontWeight: FontWeight.w500,
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
                                      //         ),
                                      //         style: FlutterFlowTheme.bodyText2
                                      //             .override(
                                      //           fontFamily: 'Montserrat',
                                      //           color: Color(0xFF8B97A2),
                                      //           fontWeight: FontWeight.w500,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(width: 20,),

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
                                              controller: addmissionFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Admission Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),

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
                                              controller: universityFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'University Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),

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
                                              controller: tutionFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Tuition Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
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
                                              controller: convacationFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Convaction Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
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
                                              controller: totalFee,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Total Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),

                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 30,top: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {

                                          if(duration!=''&&tutionFee.text!=''&&totalFee.text!=''){


                                            bool press=await alert(context, 'Add Details');
                                            if(press){
                                              coursesList.add({
                                                'duration':duration,
                                                'admissionFee':double.tryParse(addmissionFee.text.toString())??0,
                                                'convactionFee':double.tryParse(convacationFee.text.toString())??0,
                                                'universityFee':double.tryParse(universityFee.text.toString())??0,
                                                'tuitionFee':double.tryParse(tutionFee.text.toString()),
                                                'totalFee':double.tryParse(totalFee.text.toString()),
                                              });

                                              print(coursesList);

                                              duration='';
                                              convacationFee.clear();
                                              addmissionFee.clear();
                                              universityFee.clear();
                                              tutionFee.clear();
                                              totalFee.clear();
                                              showUploadMessage(context, 'New List Added');

                                              if(mounted){
                                                setState(() {

                                                });
                                              }
                                            }


                                          }else{
                                            duration==''?showUploadMessage(context, 'Please Enter Duration'):
                                            addmissionFee.text==''?showUploadMessage(context, 'Please Enter Admission Fee'):
                                            tutionFee.text==''?showUploadMessage(context, 'Please Enter Tuition Fee'):
                                            showUploadMessage(context, 'Please Enter Duration');
                                          }



                                        },
                                        text: 'Add',
                                        options: FFButtonOptions(
                                          width: 100,
                                          height: 40,
                                          color: Colors.teal,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            fontSize: 11
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


                                SizedBox(
                                  width: double.infinity,
                                  child: coursesList.length==0?Center(child: Text('No Details Added',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))): DataTable(
                                    horizontalMargin: 12,
                                    columns: [
                                      DataColumn(
                                        label: Text("Duration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                      ),
                                      DataColumn(
                                        label: Text("Admission Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("University Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Tuition Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Conviction Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Total Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                    ],
                                    rows: List.generate(
                                      coursesList.length,
                                          (index) {
                                        final history=coursesList[index];
                                        totalAmt=0;
                                        for(var data in coursesList){
                                          totalAmt+=data['totalFee'];

                                        }
                                        return DataRow(
                                          color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                          cells: [
                                            DataCell(Text(history['duration']??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(history['admissionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(history['universityFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(history['tuitionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(history['convactionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(history['totalFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),


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
                                                    bool pressed=await alert(context, 'Do you want delete Reference Details');

                                                    if(pressed){


                                                      showUploadMessage(context, 'Reference Details Deleted...');
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

                                Padding(
                                  padding: const EdgeInsets.only(right: 30,top: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [

                                      Text(
                                        'Total Fee : ${totalAmt.toStringAsFixed(2)}',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                      ),
                                      SizedBox(width: 30,),

                                      FFButtonWidget(
                                        onPressed: () async {

                                          if(course.text!=''&&courseDuration.text!=''&&eligibility.text!=''&&coursesList.isNotEmpty){

                                            if(edit==false){
                                              bool press=await alert(context, 'Add New Course');
                                              if(press){
                                                List list=[];
                                                list.add({
                                                  'courseId':CourseNameToId[course.text],
                                                  'duration':courseDuration.text,
                                                  'eligibility':eligibility.text,
                                                  'available':true,
                                                  'feeList':coursesList,
                                                  'totalFee':totalAmt,
                                                });

                                                List courseIdList=[];
                                                courseIdList.add(CourseNameToId[course.text]);

                                                university.reference.update({
                                                  'courseList':FieldValue.arrayUnion(list),
                                                  'courses':FieldValue.arrayUnion(courseIdList),
                                                });

                                                course.clear();
                                                courseDuration.clear();
                                                eligibility.clear();
                                                coursesList.clear();
                                                totalAmt=0;

                                                showUploadMessage(context, 'New Course Added...');

                                                if(mounted){
                                                  setState(() {

                                                  });
                                                }
                                              }
                                            }

                                          }else{
                                            course.text==''?showUploadMessage(context, 'Please Enter Course Name'):
                                            courseDuration.text==''?showUploadMessage(context, 'Please Enter Duration'):
                                            eligibility.text==''?showUploadMessage(context, 'Please Enter Eligibility'):
                                            showUploadMessage(context, 'Please Upload Fee Structure');
                                          }

                                        },
                                        text: 'Add Course',
                                        options: FFButtonOptions(
                                          width: 200,
                                          height: 40,
                                          color: Colors.teal,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11
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


                                SizedBox(height: 30,),


                              ],
                            ),
                          ),
                        ),
                      )

                      :Material(
                        color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20,bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),

                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(editCourseName==null?'Course Details':editCourseName,style: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                          Switch(
                                              value: available,
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              inactiveTrackColor: Colors.grey,
                                              onChanged:(value){
                                                setState(() {
                                                  print(value);
                                                  available =!available;

                                                });
                                              }
                                          ),
                                        ],
                                      ),

                                      InkWell(
                                        onTap: (){
                                          edit=false;
                                          slectedFeeIndex;
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.05,
                                          width: MediaQuery.of(context).size.width*0.1,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.red
                                          ),
                                          child: Center(
                                            child: Text('Clear',style:
                                              TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                              ),),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                                SizedBox(height: 20,),

                                slectedFeeIndex!=null?
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                                  child: Row(
                                    children: [
                                      FlutterFlowDropDown(
                                        initialOption: eDuration,
                                        options: ['First Year', 'Second Year','Third Year']
                                            .toList(),
                                        onChanged: (val) => setState(() => courseType = val),
                                        width: 180,
                                        height: 50,
                                        textStyle: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold
                                        ),
                                        hintText: 'Please select Duration',
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: Colors.black,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     width: 330,
                                      //     height: 60,
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius:
                                      //       BorderRadius.circular(8),
                                      //       border: Border.all(
                                      //         color: Color(0xFFE6E6E6),
                                      //       ),
                                      //     ),
                                      //     child: Padding(
                                      //       padding: EdgeInsets.fromLTRB(
                                      //           16, 0, 0, 0),
                                      //       child: TextFormField(
                                      //         controller: eDuration,
                                      //         obscureText: false,
                                      //         decoration: InputDecoration(
                                      //           labelText: 'Duration',
                                      //           labelStyle: FlutterFlowTheme
                                      //               .bodyText2
                                      //               .override(
                                      //             fontFamily: 'Montserrat',
                                      //             color: Color(0xFF8B97A2),
                                      //             fontWeight: FontWeight.w500,
                                      //           ),
                                      //           hintText: 'Please Enter Duration',
                                      //           hintStyle: FlutterFlowTheme
                                      //               .bodyText2
                                      //               .override(
                                      //             fontFamily: 'Montserrat',
                                      //             color: Color(0xFF8B97A2),
                                      //             fontWeight: FontWeight.w500,
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
                                      //         ),
                                      //         style: FlutterFlowTheme.bodyText2
                                      //             .override(
                                      //           fontFamily: 'Montserrat',
                                      //           color: Color(0xFF8B97A2),
                                      //           fontWeight: FontWeight.w500,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(width: 20,),

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
                                              controller: eAddmissionFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getEditTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Admission Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),

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
                                              controller: eUniversityFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getEditTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'University Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),

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
                                              controller: eTutionFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getEditTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Tuition Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
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
                                              controller: eConvacationFee,
                                              obscureText: false,
                                              onChanged: (text){
                                                getEditTotal();
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Convaction Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
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
                                              controller: eTotalFee,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Total Fee',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'Please Enter Fee',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
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
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),

                                )
                                :Container(),
                                slectedFeeIndex!=null?
                                Padding(
                                  padding: const EdgeInsets.only(right: 30,top: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {

                                          if(eDuration!=''&&eAddmissionFee.text!=''&&eUniversityFee!=''
                                              &&eTutionFee.text!=''&&eConvacationFee!=''&&eTotalFee.text!=''){


                                            bool press=await alert(context, 'update Details');
                                            if(press){

                                              eCoursesList[slectedFeeIndex]['duration']=eDuration;
                                              eCoursesList[slectedFeeIndex]['admissionFee']=double.tryParse(eAddmissionFee.text.toString())??0;
                                              eCoursesList[slectedFeeIndex]['convactionFee']=double.tryParse(eConvacationFee.text.toString())??0;
                                              eCoursesList[slectedFeeIndex]['universityFee']=double.tryParse(eUniversityFee.text.toString())??0;
                                              eCoursesList[slectedFeeIndex]['tuitionFee']=double.tryParse(eTutionFee.text.toString())??0;
                                              eCoursesList[slectedFeeIndex]['totalFee']=double.tryParse(eTotalFee.text.toString())??0;

                                              if(mounted){
                                                setState(() {

                                                });
                                                eDuration='';
                                                eAddmissionFee.clear();
                                                eConvacationFee.clear();
                                                eUniversityFee.clear();
                                                eTutionFee.clear();
                                                eTotalFee.clear();
                                                showUploadMessage(context, 'Details updated Successfully');
                                                slectedFeeIndex=null;

                                                setState(() {

                                                });
                                              }
                                            }

                                          }else{
                                            eDuration==''?showUploadMessage(context, 'Please Enter Duration'):
                                            eAddmissionFee.text==''?showUploadMessage(context, 'Please Enter Admission Fee'):
                                            eConvacationFee.text==''?showUploadMessage(context, 'Please Enter Convocation Fee'):
                                            eUniversityFee.text==''?showUploadMessage(context, 'Please Enter University Fee'):
                                            eTutionFee.text==''?showUploadMessage(context, 'Please Enter Tuition Fee'):
                                            showUploadMessage(context, 'Please Enter Total Fee');
                                          }



                                        },
                                        text: 'Update',
                                        options: FFButtonOptions(
                                          width: 100,
                                          height: 40,
                                          color: Colors.teal,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11
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
                                )
                                :Container(),

                                SizedBox(
                                  width: double.infinity,
                                  child: eCoursesList.length==0?Center(child: Text('No Details Added',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))): DataTable(
                                    horizontalMargin: 12,
                                    columns: [
                                      DataColumn(
                                        label: Text("Duration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
                                      ),
                                      DataColumn(
                                        label: Text("Admission Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("University Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Tuition Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Conviction Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("Total Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                      DataColumn(
                                        label: Text("",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),
                                      ),
                                    ],
                                    rows: List.generate(
                                      eCoursesList.length,
                                          (index) {
                                        eTotalAmt=0;
                                        for(var data in eCoursesList){
                                          eTotalAmt+=data['totalFee'];

                                        }
                                        return DataRow(
                                          color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                              :MaterialStateProperty.all(Colors.blueGrey.shade50),

                                          cells: [
                                            DataCell(Text(eCoursesList[index]['duration'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(eCoursesList[index]['admissionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(eCoursesList[index]['universityFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(eCoursesList[index]['tuitionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(eCoursesList[index]['convactionFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(Text(eCoursesList[index]['totalFee'].toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                            DataCell(   Row(
                                              children: [
                                                // Generated code for this Button Widget...
                                                FlutterFlowIconButton(
                                                  borderColor: Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 50,
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                    size: 25,
                                                  ),
                                                  onPressed: () async {

                                                    bool pressed=await alert(context, 'Do you want Edit Reference Details');

                                                    if(pressed){
                                                      print(eCoursesList[index]['duration']);
                                                      slectedFeeIndex=index;
                                                      eDuration=eCoursesList[index]['duration'];
                                                      eAddmissionFee.text=eCoursesList[index]['admissionFee'].toStringAsFixed(2);
                                                      eUniversityFee.text=eCoursesList[index]['universityFee'].toStringAsFixed(2);
                                                      eTutionFee.text=eCoursesList[index]['tuitionFee'].toStringAsFixed(2);
                                                      eConvacationFee.text=eCoursesList[index]['convactionFee'].toStringAsFixed(2);
                                                      // eTotalFee.text=eCoursesList[index]['totalFee'].toStringAsFixed(2);
                                                      print(eDuration);
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

                                Padding(
                                  padding: const EdgeInsets.only(right: 30,top: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [

                                      Text(
                                        'Total Fee : ${eTotalAmt.toStringAsFixed(2)}',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,),
                                      ),
                                      SizedBox(width: 30,),
                                      FFButtonWidget(
                                        onPressed: () async {

                                          if(universityCourses.isNotEmpty){
                                            print(universityCourses);
                                              bool press=await alert(context, 'Update Course');
                                              if(press){

                                                if(available==true){
                                                  if(!CoursesOffered.contains(universityCourses[0]['courseId'])){
                                                    CoursesOffered.add(universityCourses[0]['courseId']);
                                                  }
                                                }else{
                                                  CoursesOffered.remove(universityCourses[0]['courseId']);
                                                }


                                                Map data=universityCourses[courseMapIndex];
                                                universityCourses.removeAt(courseMapIndex);
                                                data['available']=available;
                                                universityCourses.insert(courseMapIndex, data);
                                                university.reference.update({
                                                  'courseList':universityCourses,
                                                  'courses':CoursesOffered,
                                                });

                                                showUploadMessage(context, 'New Course Added...');

                                                if(mounted){
                                                  setState(() {

                                                  });
                                                }
                                              }

                                          }

                                        },
                                        text:'Update Course',
                                        options: FFButtonOptions(
                                          width: 200,
                                          height: 40,
                                          color: Colors.teal,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11
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


                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Column(
                        children: [

                          //SEARCH &CLEAR
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                                child: Container(
                                  width: 450,
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

                                                  searchName(text);
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
                                                  fontSize: 11,
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
                                                fontSize: 11,
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
                                                universityCourses.clear();
                                                universityCourses.addAll(universityCourses1);

                                              });

                                            },
                                            text: 'Clear',
                                            options: FFButtonOptions(
                                              width: 80,
                                              height: 40,
                                              color: Color(0xFF4B39EF),
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 11,
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: universityCourses.length,
                              itemBuilder: (buildContext,int index){

                                var courseMap= universityCourses[index];

                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                                  child: Container(

                                    width: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x32000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          courseMap['available']==false?
                                          Icon(Icons.not_interested,color: Colors.red,):
                                          Icon(Icons.clear,color: Colors.white,),

                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        (index+1).toString(),
                                                        style: FlutterFlowTheme.bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFF1D2429),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        ' ${CourseIdToName[courseMap['courseId']]}  ( ${courseMap['duration']} YEARS )',
                                                        style: FlutterFlowTheme.bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFF1D2429),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'ELIGIBILITY : ${courseMap['eligibility']}',
                                                        style: FlutterFlowTheme.bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFF1D2429),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.9,
                                                    child:
                                                    DataTable(
                                                      horizontalMargin: 12,
                                                      columns: [
                                                        DataColumn(label: Text("Batch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),),
                                                        DataColumn(label: Text("Admission Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),),
                                                        DataColumn(label: Text("University Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                                        DataColumn(label: Text("Tuition Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                                        DataColumn(label: Text("Convaction Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                                        DataColumn(label: Text("Total Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                                      ],

                                                      rows: List.generate(
                                                        courseMap['feeList'].length,
                                                            (index) {
                                                          var list=courseMap['feeList'][index];


                                                          return DataRow(
                                                            color: index.isOdd?
                                                            MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                :MaterialStateProperty.all(Colors.blueGrey.shade50),

                                                            cells: [
                                                              DataCell(Text(list['duration'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                                              DataCell(Text(list['admissionFee'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                                              DataCell(Text(list['universityFee'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                                              DataCell(Text(list['tuitionFee'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                                              DataCell(Text(list['convactionFee'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                                              DataCell(Text(list['totalFee'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),

                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () {
                                               edit=true;
                                               courseMapIndex=index;
                                               available=courseMap['available'];
                                               eCoursesList=courseMap['feeList'];
                                               editCourseName=' '+CourseIdToName[courseMap['courseId']] +' ( ${courseMap['duration']} YEARS )';

                                               print(edit);
                                              setState(() {

                                              });

                                            },
                                            text: 'Edit',
                                            options: FFButtonOptions(
                                              width: 70,
                                              height: 36,
                                              color: Colors.teal,
                                              textStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
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
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(height: 50,),


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
