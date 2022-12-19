// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:smile_erp/backend/backend.dart';
// import 'package:multiple_select/multi_filter_select.dart';
// import '../../../../flutter_flow/flutter_flow_drop_down.dart';
// import '../../../../flutter_flow/flutter_flow_icon_button.dart';
// import '../../../../flutter_flow/flutter_flow_theme.dart';
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../../../flutter_flow/flutter_flow_widgets.dart';
// import '../../../../flutter_flow/upload_media.dart';
// import '../../../pages/home_page/home.dart';
// // import 'AddCourses.dart';
// // import 'AddNewCourse.dart';
// import 'EditUniversityDetails.dart';
// List editPlaces=[];
//
// class EditUniversity extends StatefulWidget {
//   final String id;
//   const EditUniversity({Key key, this.id}) : super(key: key);
//
//   @override
//   _EditUniversityState createState() => _EditUniversityState();
// }
//
// class _EditUniversityState extends State<EditUniversity> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
// TextEditingController search;
//
// List places=[];
//
//   bool edit=false;
//   String currentCourse='';
//   String courseType='Years';
//
//   List addCourseList=[];
//
//   bool switchListTileValue=true;
//   TextEditingController course;
//   TextEditingController intakeController;
//   TextEditingController tuitionFee;
//   TextEditingController intake;
//   TextEditingController duration;
//   TextEditingController admissionFee;
//   TextEditingController universityFee;
//   TextEditingController tutionFee;
//   TextEditingController yearofstudy;
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     admissionFee=TextEditingController();
//     tutionFee=TextEditingController();
//     universityFee=TextEditingController();
//     search=TextEditingController();
//     course=TextEditingController();
//     intakeController=TextEditingController();
//     tuitionFee=TextEditingController();
//     intake=TextEditingController();
//     duration=TextEditingController();
//     yearofstudy=TextEditingController();
//   }
//
// DocumentSnapshot data;
//
//   bool loaded=false;
//   List list=[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('university').doc(widget.id).snapshots(),
//         builder: (context, snapshot) {
//           if(!snapshot.hasData){
//             return Center(child: Image.asset('assets/images/loading.gif'),);
//           }
//            data=snapshot.data;
//
//           if(loaded==false){
//             loaded=true;
//             list =data['courseList'];
//           }
//
//           List availableCourses=data['courseList'];
//
//           return SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 //Banner
//                 Container(
//                   width: double.infinity,
//                   height: 260,
//                   child: Stack(
//                     alignment: AlignmentDirectional(0, 1),
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(0, -1),
//                         child: CachedNetworkImage(
//                           imageUrl:
//                               data.get('banner')==''?data.get('logo'):data.get('banner'),
//                           width: double.infinity,
//                           height: 240,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(0, -1),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       blurRadius: 8,
//                                       color: Color(0x520E151B),
//                                       offset: Offset(-1, 2),
//                                     )
//                                   ],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: FlutterFlowIconButton(
//                                   borderColor: Colors.transparent,
//                                   borderRadius: 8,
//                                   borderWidth: 1,
//                                   buttonSize: 40,
//                                   fillColor: Colors.white,
//                                   icon: Icon(
//                                     Icons.arrow_back_rounded,
//                                     color: Color(0xFF57636C),
//                                     size: 20,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(0, 1),
//                         child: ClipRect(
//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(
//                               sigmaX: 10,
//                               sigmaY: 10,
//                             ),
//                             child: Container(
//                               width: double.infinity,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 color: Color(0x801D2429),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 8, 0, 0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Container(
//                                               width: 95,
//                                               height: 75,
//                                               clipBehavior: Clip.antiAlias,
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: CachedNetworkImage(
//                                                 imageUrl: data.get('logo'),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//
//                                                 Row(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   children: [
//                                                     Text(
//                                                       data.get('name'),
//                                                       style: FlutterFlowTheme
//                                                           .title2
//                                                           .override(
//                                                         fontFamily: 'Poppins',
//                                                         color: Colors.white,
//                                                         fontSize: 20,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                     FlutterFlowIconButton(
//                                                       borderColor: Colors.transparent,
//                                                       borderRadius: 30,
//                                                       borderWidth: 0,
//                                                       buttonSize: 50,
//                                                       icon: FaIcon(
//                                                         FontAwesomeIcons.userEdit,
//                                                         color: Colors.white,
//                                                         size: 22,
//                                                       ),
//                                                       onPressed: () {
//
//
//                                                         showDialog(context: context, builder: (buildContext){
//
//                                                           return EditUniversityDetails(
//                                                             id: data.id,
//                                                             name: data['name'],
//                                                             email: data['email'],
//                                                             logo: data['logo'],
//                                                             banner: data['banner'],
//                                                             address: data['address'],
//                                                             country: countryMap[data['country']]['name'],
//
//
//                                                           );
//                                                         });
//
//                                                       },
//                                                     ),
//
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   children: [
//                                                     Text(
//                                                       data.get('email'),
//                                                       style: FlutterFlowTheme
//                                                           .subtitle2
//                                                           .override(
//                                                         fontFamily: 'Poppins',
//                                                         color: Color(0xFF31BFAE),
//                                                         fontSize: 14,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ),
//
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           FlutterFlowIconButton(
//                                             borderColor: Colors.transparent,
//                                             borderRadius: 30,
//                                             borderWidth: 1,
//                                             buttonSize: 50,
//                                             icon: FaIcon(
//                                               FontAwesomeIcons.twitter,
//                                               color: Colors.white,
//                                               size: 24,
//                                             ),
//                                             onPressed: () {
//                                             },
//                                           ),
//                                           FlutterFlowIconButton(
//                                             borderColor: Colors.transparent,
//                                             borderRadius: 30,
//                                             borderWidth: 1,
//                                             buttonSize: 50,
//                                             icon: FaIcon(
//                                               FontAwesomeIcons.linkedinIn,
//                                               color: Colors.white,
//                                               size: 24,
//                                             ),
//                                             onPressed: () {
//                                             },
//                                           ),
//                                           FlutterFlowIconButton(
//                                             borderColor: Colors.transparent,
//                                             borderRadius: 30,
//                                             borderWidth: 0,
//                                             buttonSize: 50,
//                                             icon: FaIcon(
//                                               FontAwesomeIcons.dribbble,
//                                               color: Colors.white,
//                                               size: 24,
//                                             ),
//                                             onPressed: () {
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Expanded(
//                        flex: 2,
//
//                        child: Container(
//                          child: Column(
//                            children: [
//
//                              //SEARCH &CLEAR
//                              Row(
//                                mainAxisSize: MainAxisSize.max,
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: [
//                                  Padding(
//                                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
//                                    child: Container(
//                                      width: 450,
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        boxShadow: [
//                                          BoxShadow(
//                                            blurRadius: 3,
//                                            color: Color(0x39000000),
//                                            offset: Offset(0, 1),
//                                          )
//                                        ],
//                                        borderRadius: BorderRadius.circular(12),
//                                      ),
//                                      child: Padding(
//                                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
//                                        child: Row(
//                                          mainAxisSize: MainAxisSize.max,
//                                          children: [
//                                            Expanded(
//                                              child: Padding(
//                                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
//                                                child: TextFormField(
//                                                  controller: search,
//                                                  onChanged: (text){
//                                                    setState(() {
//
//                                                    });
//                                                  },
//                                                  obscureText: false,
//                                                  decoration: InputDecoration(
//                                                    labelText: 'Search',
//                                                    hintText: 'Please Enter Name',
//                                                    labelStyle: FlutterFlowTheme
//                                                        .bodyText2
//                                                        .override(
//                                                      fontFamily: 'Poppins',
//                                                      color: Color(0xFF7C8791),
//                                                      fontSize: 11,
//                                                      fontWeight: FontWeight.bold,
//                                                    ),
//                                                    enabledBorder: OutlineInputBorder(
//                                                      borderSide: BorderSide(
//                                                        color: Color(0x00000000),
//                                                        width: 2,
//                                                      ),
//                                                      borderRadius: BorderRadius.circular(8),
//                                                    ),
//                                                    focusedBorder: OutlineInputBorder(
//                                                      borderSide: BorderSide(
//                                                        color: Color(0x00000000),
//                                                        width: 2,
//                                                      ),
//                                                      borderRadius: BorderRadius.circular(8),
//                                                    ),
//                                                    filled: true,
//                                                    fillColor: Colors.white,
//                                                  ),
//                                                  style: FlutterFlowTheme
//                                                      .bodyText1
//                                                      .override(
//                                                    fontFamily: 'Poppins',
//                                                    color: Color(0xFF090F13),
//                                                    fontSize: 11,
//                                                    fontWeight: FontWeight.normal,
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            Padding(
//                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                                              child: FFButtonWidget(
//                                                onPressed: ()  {
//
//                                                  search.clear();
//                                                  setState(() {
//
//                                                  });
//
//                                                },
//                                                text: 'Clear',
//                                                options: FFButtonOptions(
//                                                  width: 80,
//                                                  height: 40,
//                                                  color: Color(0xFF4B39EF),
//                                                  textStyle: FlutterFlowTheme
//                                                      .subtitle2
//                                                      .override(
//                                                    fontFamily: 'Poppins',
//                                                    color: Colors.white,
//                                                    fontSize: 11,
//                                                    fontWeight: FontWeight.bold,
//                                                  ),
//                                                  elevation: 2,
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius: 50,
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//
//                              ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: availableCourses.length,
//                                  itemBuilder: (buildContext,int index){
//
//                                  final courseMap= availableCourses[index];
//
//                                    return Padding(
//                                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
//                                  child: Container(
//
//                                    width: 500,
//                                    decoration: BoxDecoration(
//                                      color: Colors.white,
//                                      boxShadow: [
//                                        BoxShadow(
//                                          blurRadius: 4,
//                                          color: Color(0x32000000),
//                                          offset: Offset(0, 2),
//                                        )
//                                      ],
//                                      borderRadius: BorderRadius.circular(8),
//                                    ),
//                                    child: Padding(
//                                      padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
//                                      child: Row(
//                                        mainAxisSize: MainAxisSize.max,
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          courseMap['available']==false?
//                                          Icon(Icons.not_interested,color: Colors.red,):
//                                          Icon(Icons.clear,color: Colors.white,),
//
//                                          Expanded(
//                                            child: Padding(
//                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                                              child: Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: [
//                                                  Row(
//                                                    children: [
//                                                      Text(
//                                                        courseMap['courseId'],
//                                                        style: FlutterFlowTheme.bodyText1.override(
//                                                          fontFamily: 'Poppins',
//                                                          color: Color(0xFF1D2429),
//                                                          fontSize: 12,
//                                                          fontWeight: FontWeight.w700,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 5,),
//                                                      Text(
//                                                        ' '+CourseIdToName[courseMap['courseId']],
//                                                        style: FlutterFlowTheme.bodyText1.override(
//                                                          fontFamily: 'Poppins',
//                                                          color: Color(0xFF1D2429),
//                                                          fontSize: 12,
//                                                          fontWeight: FontWeight.w700,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  Row(
//                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                    children: [
//                                                      Text(
//                                                        courseMap['duration'],
//                                                        style: FlutterFlowTheme.bodyText1.override(
//                                                          fontFamily: 'Poppins',
//                                                          color: Color(0xFF1D2429),
//                                                          fontSize: 10,
//                                                          fontWeight: FontWeight.w700,
//                                                        ),
//                                                      ),
//                                                      Padding(
//                                                        padding: const EdgeInsets.only(right: 30),
//                                                        child: Text(
//                                                          courseMap['fee'].toString(),
//                                                          style: FlutterFlowTheme.bodyText1.override(
//                                                            fontFamily: 'Poppins',
//                                                            color: Color(0xFF1D2429),
//                                                            fontSize: 10,
//                                                            fontWeight: FontWeight.w700,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//                                          FFButtonWidget(
//                                            onPressed: () {
//
//                                              edit=true;
//                                              course.text=CourseNameToId[courseMap['name']];
//                                              tuitionFee.text=courseMap['tuitionFee'];
//
//                                              setState(() {
//
//                                              });
//                                            },
//                                            text: 'Edit',
//                                            options: FFButtonOptions(
//                                              width: 70,
//                                              height: 36,
//                                              color: Colors.teal,
//                                              textStyle: FlutterFlowTheme.bodyText1.override(
//                                                fontFamily: 'Poppins',
//                                                color: Colors.white,
//                                                fontSize: 10,
//                                                fontWeight: FontWeight.bold,
//                                              ),
//                                              borderSide: BorderSide(
//                                                color: Colors.transparent,
//                                                width: 1,
//                                              ),
//                                              borderRadius: 8,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                );
//                              }),
//                            ],
//                          ),
//                        ),
//                      ),
//
//                      if (edit==true) Expanded(
//                          flex: 3,
//                          child: Container(
//                            child: Column(
//                              children: [
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: [
//                                    SizedBox(width: 70,),
//
//                                    Expanded(
//                                      child: SwitchListTile(
//                                        value: switchListTileValue ??= true,
//                                        onChanged: (newValue) => setState(() => switchListTileValue = newValue),
//                                        title: Text(
//                                          'Available',
//                                          style: FlutterFlowTheme.title3.override(
//                                            fontFamily: 'Poppins',
//                                            color: Colors.black,
//                                          ),
//                                        ),
//                                        tileColor: Colors.white,
//                                        activeColor: Colors.grey,
//                                        activeTrackColor: Colors.teal,
//                                        dense: false,
//
//                                        controlAffinity: ListTileControlAffinity.leading,
//                                      ),
//                                    ),
//
//
//                                    Padding(
//                                      padding: const EdgeInsets.all(10.0),
//                                      child: Row(
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        children: [
//                                          Material(
//                                            color: Colors.transparent,
//                                            elevation: 10,
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(30),
//                                            ),
//                                            child: InkWell(
//                                              onTap: ()  {
//
//                                                edit=false;
//                                                tuitionFee.clear();
//                                                editPlaces.clear();
//                                                addCourseList.clear();
//                                                course.clear();
//
//                                                setState(() {
//
//                                                });
//
//
//                                              },
//                                              child: Container(
//                                                height: 100,
//                                                constraints: BoxConstraints(
//                                                  maxHeight: 50,
//                                                ),
//                                                decoration: BoxDecoration(
//                                                  color: Colors.red,
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      blurRadius: 4,
//                                                      color:
//                                                      Color(0x32171717),
//                                                      offset: Offset(0, 2),
//                                                    )
//                                                  ],
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      30),
//                                                  shape: BoxShape.rectangle,
//                                                ),
//                                                child: Padding(
//                                                  padding:
//                                                  EdgeInsetsDirectional
//                                                      .fromSTEB(
//                                                      8, 0, 8, 0),
//                                                  child: Row(
//                                                    mainAxisSize:
//                                                    MainAxisSize.max,
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment
//                                                        .center,
//                                                    children: [
//
//                                                      Padding(
//                                                        padding:
//                                                        EdgeInsetsDirectional
//                                                            .fromSTEB(5,
//                                                            5, 5, 5),
//                                                        child: Text(
//                                                          'Clear',
//                                                          style:
//                                                          FlutterFlowTheme
//                                                              .bodyText1
//                                                              .override(
//                                                            fontFamily:
//                                                            'Lexend Deca',
//                                                            color:
//                                                            Colors.white,
//                                                            fontSize: 12,
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .bold,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    SizedBox(width: 70,),
//
//
//                                  ],
//                                ),
//
//                                Row(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//
//                                  children: [
//                                    SizedBox(width: 30,),
//
//                                    Expanded(
//                                      child: Column(
//
//                                        children: [
//                                          Padding(
//                                            padding: const EdgeInsets.all(8.0),
//                                            child: Row(
//                                              children: [
//                                                SizedBox(width: 10,),
//                                                Expanded(
//                                                  child: Container(
//                                                    width: 330,
//                                                    height: 60,
//                                                    decoration: BoxDecoration(
//                                                      color: Colors.white,
//                                                      boxShadow: [
//                                                        BoxShadow(
//                                                          blurRadius: 5,
//                                                          color: Color(0x4D101213),
//                                                          offset: Offset(0, 2),
//                                                        )
//                                                      ],
//                                                      borderRadius: BorderRadius.circular(8),
//                                                    ),
//                                                    child: CustomDropdown.search(
//                                                      hintText: 'Select Course',
//                                                      items: courses,
//                                                      controller: course,
//                                                      excludeSelected: false,
//                                                      onChanged: (text){
//                                                        setState(() {
//
//
//                                                        });
//
//                                                      },
//                                                    ),
//                                                  ),
//                                                ),
//
//                                                SizedBox(width: 20,),
//                                              ],
//                                            ),
//                                          ),
//
//                                          //Course Adding
//                                          Padding(
//                                            padding: const EdgeInsets.all(8.0),
//                                            child: Row(
//                                              children: [
//                                                Expanded(
//                                                  child: Container(
//                                                    width: 330,
//                                                    height: 60,
//                                                    decoration: BoxDecoration(
//                                                      color: Colors.white,
//                                                      borderRadius:
//                                                      BorderRadius.circular(8),
//                                                      border: Border.all(
//                                                        color: Color(0xFFE6E6E6),
//                                                      ),
//                                                    ),
//                                                    child: Padding(
//                                                      padding: EdgeInsets.fromLTRB(
//                                                          16, 0, 0, 0),
//                                                      child: TextFormField(
//                                                        controller: duration,
//                                                        obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          labelText: 'Duration',
//                                                          labelStyle: FlutterFlowTheme
//                                                              .bodyText2
//                                                              .override(
//                                                            fontFamily: 'Montserrat',
//                                                            color: Color(0xFF8B97A2),
//                                                            fontWeight: FontWeight.w500,
//                                                            fontSize: 11,
//                                                          ),
//                                                          hintText: 'Please Enter Duration',
//                                                          hintStyle: FlutterFlowTheme
//                                                              .bodyText2
//                                                              .override(
//                                                            fontFamily: 'Montserrat',
//                                                            color: Color(0xFF8B97A2),
//                                                            fontWeight: FontWeight.w500,
//                                                            fontSize: 11,
//
//                                                          ),
//                                                          enabledBorder:
//                                                          UnderlineInputBorder(
//                                                            borderSide: BorderSide(
//                                                              color: Colors.transparent,
//                                                              width: 1,
//                                                            ),
//                                                            borderRadius:
//                                                            const BorderRadius.only(
//                                                              topLeft:
//                                                              Radius.circular(4.0),
//                                                              topRight:
//                                                              Radius.circular(4.0),
//                                                            ),
//                                                          ),
//                                                          focusedBorder:
//                                                          UnderlineInputBorder(
//                                                            borderSide: BorderSide(
//                                                              color: Colors.transparent,
//                                                              width: 1,
//                                                            ),
//                                                            borderRadius:
//                                                            const BorderRadius.only(
//                                                              topLeft:
//                                                              Radius.circular(4.0),
//                                                              topRight:
//                                                              Radius.circular(4.0),
//                                                            ),
//                                                          ),
//                                                        ),
//                                                        style: FlutterFlowTheme.bodyText2
//                                                            .override(
//                                                          fontFamily: 'Montserrat',
//                                                          color: Color(0xFF8B97A2),
//                                                          fontWeight: FontWeight.w500,
//                                                          fontSize: 11,
//
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ),
//                                                ),
//                                                SizedBox(width: 10,),
//                                                Expanded(
//                                                  flex: 2,
//                                                  child: FlutterFlowDropDown(
//                                                    initialOption: courseType??'Years',
//                                                    options: ['Months', 'Years']
//                                                        .toList(),
//                                                    onChanged: (val) => setState(() => courseType = val),
//                                                    width: 180,
//                                                    height: 50,
//                                                    textStyle: FlutterFlowTheme.bodyText1.override(
//                                                        fontFamily: 'Poppins',
//                                                        color: Colors.black,
//                                                        fontSize: 11,
//                                                        fontWeight: FontWeight.bold
//                                                    ),
//                                                    hintText: 'Please select Duration',
//                                                    fillColor: Colors.white,
//                                                    elevation: 2,
//                                                    borderColor: Colors.black,
//                                                    borderWidth: 0,
//                                                    borderRadius: 0,
//                                                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
//                                                    hidesUnderline: true,
//                                                  ),
//                                                ),
//                                                SizedBox(width: 10,),
//                                                Expanded(
//                                                  flex: 2,
//                                                  child: Container(
//                                                    width: 330,
//                                                    height: 60,
//                                                    decoration: BoxDecoration(
//                                                      color: Colors.white,
//                                                      borderRadius:
//                                                      BorderRadius.circular(8),
//                                                      border: Border.all(
//                                                        color: Color(0xFFE6E6E6),
//                                                      ),
//                                                    ),
//                                                    child: Padding(
//                                                      padding: EdgeInsets.fromLTRB(
//                                                          16, 0, 0, 0),
//                                                      child: TextFormField(
//                                                        controller: tuitionFee,
//                                                        obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          labelText: 'Tuition Fee',
//                                                          labelStyle: FlutterFlowTheme
//                                                              .bodyText2
//                                                              .override(
//                                                            fontFamily: 'Montserrat',
//                                                            color: Color(0xFF8B97A2),
//                                                            fontWeight: FontWeight.w500,
//                                                            fontSize: 11,
//                                                          ),
//                                                          hintText: 'Please Enter Fee',
//                                                          hintStyle: FlutterFlowTheme
//                                                              .bodyText2
//                                                              .override(
//                                                            fontFamily: 'Montserrat',
//                                                            color: Color(0xFF8B97A2),
//                                                            fontWeight: FontWeight.w500,
//                                                            fontSize: 11,
//
//                                                          ),
//                                                          enabledBorder:
//                                                          UnderlineInputBorder(
//                                                            borderSide: BorderSide(
//                                                              color: Colors.transparent,
//                                                              width: 1,
//                                                            ),
//                                                            borderRadius:
//                                                            const BorderRadius.only(
//                                                              topLeft:
//                                                              Radius.circular(4.0),
//                                                              topRight:
//                                                              Radius.circular(4.0),
//                                                            ),
//                                                          ),
//                                                          focusedBorder:
//                                                          UnderlineInputBorder(
//                                                            borderSide: BorderSide(
//                                                              color: Colors.transparent,
//                                                              width: 1,
//                                                            ),
//                                                            borderRadius:
//                                                            const BorderRadius.only(
//                                                              topLeft:
//                                                              Radius.circular(4.0),
//                                                              topRight:
//                                                              Radius.circular(4.0),
//                                                            ),
//                                                          ),
//                                                        ),
//                                                        style: FlutterFlowTheme.bodyText2
//                                                            .override(
//                                                          fontFamily: 'Montserrat',
//                                                          color: Color(0xFF8B97A2),
//                                                          fontWeight: FontWeight.w500,
//                                                          fontSize: 11,
//
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ),
//                                                ),
//                                                SizedBox(width: 10,),
//
//                                              ],
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//
//                                    Padding(
//                                      padding: EdgeInsets.all(8),
//                                      child: Row(
//                                        children: [
//
//                                        ],
//                                      ),
//                                    ),
//                                    SizedBox(width: 50,),
//                                  ],
//                                ),
//                              ],
//                            ),
//
//                          )) else Expanded(
//                        flex: 3,
//                          child: Container(
//
//                            child: Column(
//                              children: [
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: [
//
//                                    Padding(
//                                      padding: const EdgeInsets.all(10.0),
//                                      child: Row(
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        children: [
//                                          Material(
//                                            color: Colors.transparent,
//                                            elevation: 10,
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(30),
//                                            ),
//                                            child: InkWell(
//                                              onTap: () async {
//                                                //
//                                                // String name= await     showDialog(context: context,
//                                                //     builder: (buildContext){
//                                                //       return AddNewCourse();
//                                                //     });
//                                                // if(name!=null){
//                                                //   if(name.contains(name)){
//                                                //     course.text=name;
//                                                //   }
//                                                //   setState(() {
//                                                //
//                                                //   });
//                                                // }else{
//                                                //   showUploadMessage(context, 'Section was Cancelled...');
//                                                // }
//                                              },
//                                              child: Container(
//                                                height: 100,
//                                                constraints: BoxConstraints(
//                                                  maxHeight: 50,
//                                                ),
//                                                decoration: BoxDecoration(
//                                                  color: Color(0xFF4B39EF),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      blurRadius: 4,
//                                                      color:
//                                                      Color(0x32171717),
//                                                      offset: Offset(0, 2),
//                                                    )
//                                                  ],
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      30),
//                                                  shape: BoxShape.rectangle,
//                                                ),
//                                                child: Padding(
//                                                  padding:
//                                                  EdgeInsetsDirectional
//                                                      .fromSTEB(
//                                                      8, 0, 8, 0),
//                                                  child: Row(
//                                                    mainAxisSize:
//                                                    MainAxisSize.max,
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment
//                                                        .center,
//                                                    children: [
//
//                                                      Padding(
//                                                        padding:
//                                                        EdgeInsetsDirectional
//                                                            .fromSTEB(8,
//                                                            0, 0, 0),
//                                                        child: Text(
//                                                          'New Course',
//                                                          style:
//                                                          FlutterFlowTheme
//                                                              .bodyText1
//                                                              .override(
//                                                            fontFamily:
//                                                            'Lexend Deca',
//                                                            color:
//                                                            Colors.white,
//                                                            fontSize: 12,
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .bold,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    SizedBox(width: 70,),
//                                  ],
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Row(
//                                    children: [
//                                      SizedBox(width: 10,),
//                                      Expanded(
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            boxShadow: [
//                                              BoxShadow(
//                                                blurRadius: 5,
//                                                color: Color(0x4D101213),
//                                                offset: Offset(0, 2),
//                                              )
//                                            ],
//                                            borderRadius: BorderRadius.circular(8),
//                                          ),
//                                          child: CustomDropdown.search(
//                                            hintText: 'Select Course',
//                                            items: courses,
//                                            controller: course,
//                                            excludeSelected: false,
//                                            onChanged: (text){
//                                              setState(() {
//
//
//                                              });
//                                            },
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(width: 20,),
//                                    ],
//                                  ),
//                                ),
//
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Row(
//                                    children: [
//                                      Expanded(
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius:
//                                            BorderRadius.circular(8),
//                                            border: Border.all(
//                                              color: Color(0xFFE6E6E6),
//                                            ),
//                                          ),
//                                          child: Padding(
//                                            padding: EdgeInsets.fromLTRB(
//                                                16, 0, 0, 0),
//                                            child: TextFormField(
//                                              controller: duration,
//                                              obscureText: false,
//                                              decoration: InputDecoration(
//                                                labelText: 'Duration',
//                                                labelStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//                                                ),
//                                                hintText: 'Please Enter Duration',
//                                                hintStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//
//                                                ),
//                                                enabledBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                                focusedBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                              ),
//                                              style: FlutterFlowTheme.bodyText2
//                                                  .override(
//                                                fontFamily: 'Montserrat',
//                                                color: Color(0xFF8B97A2),
//                                                fontWeight: FontWeight.w500,
//                                                fontSize: 11,
//
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(width: 10,),
//                                      Expanded(
//                                          flex: 2,
//
//                                        child: FlutterFlowDropDown(
//                                          initialOption: courseType??'Years',
//                                          options: ['Months', 'Years']
//                                              .toList(),
//                                          onChanged: (val) => setState(() => courseType = val),
//                                          width: 180,
//                                          height: 50,
//                                          textStyle: FlutterFlowTheme.bodyText1.override(
//                                            fontFamily: 'Poppins',
//                                            color: Colors.black,
//                                              fontSize: 11,
//                                              fontWeight: FontWeight.bold
//                                          ),
//                                          hintText: 'Please select Duration',
//                                          fillColor: Colors.white,
//                                          elevation: 2,
//                                          borderColor: Colors.black,
//                                          borderWidth: 0,
//                                          borderRadius: 0,
//                                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
//                                          hidesUnderline: true,
//                                        ),
//                                      ),
//                                      SizedBox(width: 10,),
//                                      Expanded(
//                                        flex: 2,
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius:
//                                            BorderRadius.circular(8),
//                                            border: Border.all(
//                                              color: Color(0xFFE6E6E6),
//                                            ),
//                                          ),
//                                          child: Padding(
//                                            padding: EdgeInsets.fromLTRB(
//                                                16, 0, 0, 0),
//                                            child: TextFormField(
//                                              controller: tuitionFee,
//                                              obscureText: false,
//                                              decoration: InputDecoration(
//                                                labelText: 'Tuition Fee',
//                                                labelStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//                                                ),
//                                                hintText: 'Please Enter Fee',
//                                                hintStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//
//                                                ),
//                                                enabledBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                                focusedBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                              ),
//                                              style: FlutterFlowTheme.bodyText2
//                                                  .override(
//                                                fontFamily: 'Montserrat',
//                                                color: Color(0xFF8B97A2),
//                                                fontWeight: FontWeight.w500,
//                                                fontSize: 11,
//
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(width: 10,),
//
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(width: 50,),
//                                SizedBox(height: 5,),
//                                Row(
//                                  children: [
//                                    Expanded(
//                                      flex: 2,
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius:
//                                            BorderRadius.circular(8),
//                                            border: Border.all(
//                                              color: Color(0xFFE6E6E6),
//                                            ),
//                                          ),
//                                          child: Padding(
//                                            padding: EdgeInsets.fromLTRB(
//                                                16, 0, 0, 0),
//                                            child: TextFormField(
//                                              controller: admissionFee,
//                                              obscureText: false,
//                                              decoration: InputDecoration(
//                                                labelText: 'Admission Fee',
//                                                labelStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//                                                ),
//                                                hintText: 'Please Enter Admission Fee',
//                                                hintStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//
//                                                ),
//                                                enabledBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                                focusedBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                              ),
//                                              style: FlutterFlowTheme.bodyText2
//                                                  .override(
//                                                fontFamily: 'Montserrat',
//                                                color: Color(0xFF8B97A2),
//                                                fontWeight: FontWeight.w500,
//                                                fontSize: 11,
//
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 2,
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius:
//                                            BorderRadius.circular(8),
//                                            border: Border.all(
//                                              color: Color(0xFFE6E6E6),
//                                            ),
//                                          ),
//                                          child: Padding(
//                                            padding: EdgeInsets.fromLTRB(
//                                                16, 0, 0, 0),
//                                            child: TextFormField(
//                                              controller: universityFee,
//                                              obscureText: false,
//                                              decoration: InputDecoration(
//                                                labelText: 'University Fee',
//                                                labelStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//                                                ),
//                                                hintText: 'Please Enter University Fee',
//                                                hintStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//
//                                                ),
//                                                enabledBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                                focusedBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                              ),
//                                              style: FlutterFlowTheme.bodyText2
//                                                  .override(
//                                                fontFamily: 'Montserrat',
//                                                color: Color(0xFF8B97A2),
//                                                fontWeight: FontWeight.w500,
//                                                fontSize: 11,
//
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 2,
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                          width: 330,
//                                          height: 60,
//                                          decoration: BoxDecoration(
//                                            color: Colors.white,
//                                            borderRadius:
//                                            BorderRadius.circular(8),
//                                            border: Border.all(
//                                              color: Color(0xFFE6E6E6),
//                                            ),
//                                          ),
//                                          child: Padding(
//                                            padding: EdgeInsets.fromLTRB(
//                                                16, 0, 0, 0),
//                                            child: TextFormField(
//                                              controller: tutionFee,
//                                              obscureText: false,
//                                              decoration: InputDecoration(
//                                                labelText: 'Tution Fee',
//                                                labelStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//                                                ),
//                                                hintText: 'Please Enter Tution Fee',
//                                                hintStyle: FlutterFlowTheme
//                                                    .bodyText2
//                                                    .override(
//                                                  fontFamily: 'Montserrat',
//                                                  color: Color(0xFF8B97A2),
//                                                  fontWeight: FontWeight.w500,
//                                                  fontSize: 11,
//
//                                                ),
//                                                enabledBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                                focusedBorder:
//                                                UnderlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                    color: Colors.transparent,
//                                                    width: 1,
//                                                  ),
//                                                  borderRadius:
//                                                  const BorderRadius.only(
//                                                    topLeft:
//                                                    Radius.circular(4.0),
//                                                    topRight:
//                                                    Radius.circular(4.0),
//                                                  ),
//                                                ),
//                                              ),
//                                              style: FlutterFlowTheme.bodyText2
//                                                  .override(
//                                                fontFamily: 'Montserrat',
//                                                color: Color(0xFF8B97A2),
//                                                fontWeight: FontWeight.w500,
//                                                fontSize: 11,
//
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                  ],
//                                ),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: [
//                                    InkWell(
//                                      onTap:(){
//                                        List datas=[];
//
//                                        datas.add({
//
//                                          'admissionFee':double.tryParse(admissionFee.text),
//                                          'tutionFee':double.tryParse(tutionFee.text),
//                                          'universityFee':double.tryParse(universityFee.text)
//                                        });
//
//                                      },
//                                      child: Container(
//                                        height: MediaQuery.of(context).size.height*0.06,
//                                        width: MediaQuery.of(context).size.width*0.05,
//                                        decoration: BoxDecoration(
//                                          color: Color(0xFF4B39EF),
//                                          borderRadius: BorderRadius.circular(15),
//                                        ),
//                                        child: Center(child: Text('Add',style: TextStyle(fontSize: 14,color: Colors.white),)
//                                          ,)
//                                      ),
//                                    ),
//                                    SizedBox(width: 10,),
//                                  ],
//                                ),
//
//
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: [
//
//                                    Padding(
//                                      padding: const EdgeInsets.all(10.0),
//                                      child: Row(
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        children: [
//                                          Material(
//                                            color: Colors.transparent,
//                                            elevation: 10,
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(30),
//                                            ),
//                                            child: InkWell(
//                                              onTap: () async {
//
//                                                if(duration.text!=''&&courseType!=''&&tuitionFee.text!=''){
//
//                                                  addCourseList.add({
//                                                    'duration':duration.text +' $courseType',
//                                                    'fee':double.tryParse(tuitionFee.text.toString())??0,
//                                                    'courseId':CourseNameToId[course.text],
//                                                  });
//                                                  print(addCourseList);
//                                                  List courseIdList=[];
//                                                  courseIdList.add(CourseNameToId[course.text]);
//
//                                                  FirebaseFirestore.instance.collection('university').doc(widget.id).update({
//                                                    'courseList':FieldValue.arrayUnion(addCourseList),
//                                                    'courses':FieldValue.arrayUnion(courseIdList),
//                                                  });
//
//                                                  setState(() {
//                                                    duration.clear();
//                                                    tuitionFee.clear();
//                                                    course.clear();
//
//                                                  });
//                                                  showUploadMessage(context, 'course added successfully');
//                                                }else{
//                                                  duration.text==''?showUploadMessage(context, 'Please Enter Duration')
//                                                  :courseType==''?showUploadMessage(context, 'Please select course type')
//                                                  :showUploadMessage(context, 'please enter fee');
//                                                }
//
//
//                                              },
//                                              child: Container(
//                                                height: 100,
//                                                constraints: BoxConstraints(
//                                                  maxHeight: 50,
//                                                ),
//                                                decoration: BoxDecoration(
//                                                  color: Color(0xFF4B39EF),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      blurRadius: 4,
//                                                      color:
//                                                      Color(0x32171717),
//                                                      offset: Offset(0, 2),
//                                                    )
//                                                  ],
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      30),
//                                                  shape: BoxShape.rectangle,
//                                                ),
//                                                child: Padding(
//                                                  padding:
//                                                  EdgeInsetsDirectional
//                                                      .fromSTEB(
//                                                      8, 0, 8, 0),
//                                                  child: Row(
//                                                    mainAxisSize:
//                                                    MainAxisSize.max,
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment
//                                                        .center,
//                                                    children: [
//
//                                                      Padding(
//                                                        padding:
//                                                        EdgeInsetsDirectional
//                                                            .fromSTEB(8,
//                                                            0, 0, 0),
//                                                        child: Text(
//                                                          'Create Course',
//                                                          style:
//                                                          FlutterFlowTheme
//                                                              .bodyText1
//                                                              .override(
//                                                            fontFamily:
//                                                            'Lexend Deca',
//                                                            color:
//                                                            Colors.white,
//                                                            fontSize: 12,
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .bold,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    SizedBox(width: 70,),
//
//
//                                  ],
//                                ),
//
//                              ],
//                            ),
//
//                          )),
//                    ],
//                  ),
//                )
//
//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }
// }
//
// class EditBox extends StatefulWidget {
//   final String name;
//   const EditBox({Key key, this.name}) : super(key: key);
//
//   @override
//   State<EditBox> createState() => _EditBoxState();
// }
//
// class _EditBoxState extends State<EditBox> {
//
//   bool checked=false;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     if(editPlaces.contains(widget.name)){
//       checked=true;
//
//     }else{
//       checked=false;
//
//     }
//     return Row(
//       children: [
//         Text(widget.name),
//         Checkbox(value: checked, onChanged: (value){
//
//           if(editPlaces.contains(widget.name)){
//             checked=false;
//             editPlaces.remove(widget.name);
//
//           }else{
//             editPlaces.add(widget.name);
//           }
//
//           checked=value;
//           setState(() {
//
//
//           });
//
//         }),
//       ],
//     );
//   }
// }
