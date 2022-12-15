import 'package:cached_network_image/cached_network_image.dart';
import 'package:smile_erp/app/app_widget.dart';
import 'package:smile_erp/auth/auth_util.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:rating_bar/rating_bar.dart';

import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import '../../pages/home_page/home.dart';
import '../Student/RegisterForm.dart';
import '../University/CheckCriteria.dart';
import 'EditEnquiry.dart';

class EnquiryDetailsWidget extends StatefulWidget {
  final String id;

  const EnquiryDetailsWidget({Key key, this.id}) : super(key: key);

  @override
  _EnquiryDetailsWidgetState createState() => _EnquiryDetailsWidgetState();
}

class _EnquiryDetailsWidgetState extends State<EnquiryDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List educationalDetails = [];

  TextEditingController status;
  Timestamp datePicked1;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

 TextEditingController reason;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = TextEditingController();

    reason=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF090F13),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('enquiry')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(  color: Colors.white,
                  child: Center(child: Image.asset('assets/images/loading.gif'),));
            }
            var data = snapshot.data;
            if (snapshot.data.exists) {
              educationalDetails = snapshot.data.get('educationalDetails');


            }
            return !data.exists
                ? Center(
                    child: Text('Loading...'),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Expanded(
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [

                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                     if(data['status']==0){
                                                       bool pressed = await alert(
                                                           context,
                                                           'Edit Details');

                                                       if (pressed) {
                                                         Navigator.push(
                                                             context,
                                                             MaterialPageRoute(
                                                                 builder: (context) =>
                                                                     EditEnquiry(
                                                                       eId: data.id,
                                                                     )));
                                                       }
                                                     }else{
                                                       showUploadMessage(context, 'This Enquiry Already Converted to Student...');
                                                     }
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      constraints: BoxConstraints(
                                                        maxHeight: 50,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF4B39EF),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 4,
                                                            color:
                                                                Color(0x32171717),
                                                            offset: Offset(0, 2),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8, 0, 8, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color: Colors.white,
                                                              size: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(8,
                                                                          0, 0, 0),
                                                              child: Text(
                                                                'Edit Details',
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color:
                                                                      Colors.white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 8, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Name : ' + data['name'],
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 8, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ID : ' + data.id,
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(data['dob']!=null?
                                                  'DOB : ${dateTimeFormat('dd-MMM-yyyy', data['dob'].toDate())}':'DOB :',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Mobile : ' + data['mobile'],
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Place : ' + data['place'],
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Email : ' + data['email'],
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('course : ',style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                Text(
                                                  CourseIdToName[data['courses']]!=null?
                                                  CourseIdToName[data['courses']]
                                                  :'',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Education Board : ',style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                Text(
                                                  UniversityIdToName[data['university']]!=null?
                                                  UniversityIdToName[data['university']]
                                                  :'',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status : ',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  data['status']==0?'Pending':
                                                  data['status']==1?'Student':
                                                  'Dead Enquiry',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:  data['status']==0?Color(0xFF57636C):
                                                    data['status']==1?Colors.blue:
                                                    Colors.red,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          data['status']==2?
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 5, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Reason : ${data['reason']}',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ):
                                          Container(),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Enquiry Registered on : ' +
                                                      dateTimeFormat('d-MMM-y', data['date'].toDate()),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),


                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24, 12, 0, 12),
                                                      child: Text(
                                                        'Educational Details',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color:
                                                              Color(0xFF090F13),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 20, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 5,
                                                          color:
                                                              Color(0x3416202A),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 8, 8, 8),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                'Qualification',
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                'institute',
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Year',
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: List.generate(
                                                                educationalDetails
                                                                    .length,
                                                                (index) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            8.0),
                                                                    child: Text(educationalDetails[index]['qualification'],
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      educationalDetails[index]['institute']??'',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                      educationalDetails[index]['year'],
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(10.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //     children: [
                                          //       Material(
                                          //         color: Colors.transparent,
                                          //         elevation: 10,
                                          //         shape: RoundedRectangleBorder(
                                          //           borderRadius:
                                          //           BorderRadius.circular(30),
                                          //         ),
                                          //         child: InkWell(
                                          //           onTap: () async {
                                          //          if(data['status']==0){
                                          //            List unId = [];
                                          //
                                          //            bool pressed = await alert(
                                          //                context,
                                          //                'Check Eligibility');
                                          //
                                          //            if (pressed) {
                                          //
                                          //              unId=await  Navigator.push(
                                          //                  context,
                                          //                  MaterialPageRoute(builder: (context)=>
                                          //                      UniversityListWidget()));
                                          //
                                          //            }
                                          //            if (unId.length != 0) {
                                          //              print(unId);
                                          //
                                          //              snapshot.data.reference
                                          //                  .update({
                                          //                'university': unId,
                                          //                'check':true,
                                          //              });
                                          //            }
                                          //          }else{
                                          //            showUploadMessage(context, 'This Enquiry Already Converted to Student...');
                                          //
                                          //          }
                                          //           },
                                          //           child: Container(
                                          //             height: 100,
                                          //             constraints: BoxConstraints(
                                          //               maxHeight: 50,
                                          //             ),
                                          //             decoration: BoxDecoration(
                                          //               color: Color(0xFF4B39EF),
                                          //               boxShadow: [
                                          //                 BoxShadow(
                                          //                   blurRadius: 4,
                                          //                   color:
                                          //                   Color(0x32171717),
                                          //                   offset: Offset(0, 2),
                                          //                 )
                                          //               ],
                                          //               borderRadius:
                                          //               BorderRadius.circular(
                                          //                   30),
                                          //               shape: BoxShape.rectangle,
                                          //             ),
                                          //             child: Padding(
                                          //               padding:
                                          //               EdgeInsetsDirectional
                                          //                   .fromSTEB(
                                          //                   8, 0, 8, 0),
                                          //               child: Row(
                                          //                 mainAxisSize:
                                          //                 MainAxisSize.max,
                                          //                 mainAxisAlignment:
                                          //                 MainAxisAlignment
                                          //                     .center,
                                          //                 children: [
                                          //                   Icon(
                                          //                     Icons.playlist_add_check,
                                          //                     color: Colors.white,
                                          //                     size: 20,
                                          //                   ),
                                          //                   Padding(
                                          //                     padding:
                                          //                     EdgeInsetsDirectional
                                          //                         .fromSTEB(8,
                                          //                         0, 8, 0),
                                          //                     child: Text(
                                          //                       'Check Eligibility',
                                          //                       style:
                                          //                       FlutterFlowTheme
                                          //                           .bodyText1
                                          //                           .override(
                                          //                         fontFamily:
                                          //                         'Lexend Deca',
                                          //                         color:
                                          //                         Colors.white,
                                          //                         fontSize: 12,
                                          //                         fontWeight:
                                          //                         FontWeight
                                          //                             .normal,
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),

                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(24, 12, 0, 12),
                                                    child: Text(
                                                      'Additional Info',
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF090F13),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(24, 0, 0, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      data.get('additionalInfo'),
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF090F13),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          //Dead Enquiry
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                                                child: InkWell(
                                                  onTap:() async {
                                                    if(data['status']==0){
                                                      return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text('Register As Dead Enquiry'),
                                                          content: TextField(
                                                            controller: reason,
                                                            decoration: InputDecoration(
                                                                hintText: "Enter Reason"),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: (){
                                                              Navigator.pop(context);
                                                              },
                                                              child: Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      fontSize: 18.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black
                                                                  )
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: (){
                                                                if(data['status']==0){
                                                                  FirebaseFirestore.instance.collection('enquiry').doc(widget.id).update({
                                                                    'status': 2,
                                                                    'reason':reason.text,
                                                                  });
                                                                  Navigator.pop(context);
                                                                }
                                                              },
                                                              child: Text(
                                                                  'Yes',
                                                                  style: TextStyle(
                                                                      fontSize: 18.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                    }else if(data['status']==1){
                                                      showUploadMessage(context, 'This Enquiry Already Converted As Student');
                                                    }else {
                                                      showUploadMessage(context, 'This Enquiry Already Converted As Dead Enquiry');
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF4B39EF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                          Color(0x32171717),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          8, 0, 8, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Icon(
                                                            Icons.person_add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(8,
                                                                0, 0, 0),
                                                            child: Text(
                                                              'Dead Enquiry',
                                                              style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Lexend Deca',
                                                                color:
                                                                Colors.white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //Register As Student
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [

                                              SizedBox(width: 30,),
                                              Material(
                                                color: Colors.transparent,
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () async {

                                                    if(data['status']==0 || data['status']==2 ){

                                                      bool pressed = await alert(context, 'Register As Student');

                                                      if (pressed) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    RegistrationFormWidget(
                                                                      universityId: data['university'],
                                                                      name: data['name'],
                                                                      mobile: data['mobile'],
                                                                      email: data['email'],
                                                                      dob: data['dob'].toDate(),
                                                                      place: data['place'],
                                                                      additionalInfo: data['additionalInfo'],
                                                                      educationalDetails: educationalDetails,
                                                                      eId: data.id,
                                                                      courses:data['courses'],
                                                                      phnCode:data['phoneCode'],
                                                                      cntyCode: data['countryCode'],

                                                                    )));
                                                      }
                                                    }else{
                                                      showUploadMessage(context, 'This Enquiry Already Converted to Student...');
                                                    }

                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF4B39EF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                          Color(0x32171717),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          8, 0, 8, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Icon(
                                                            Icons.person_add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(8,
                                                                0, 0, 0),
                                                            child: Text(
                                                              'Register As Student',
                                                              style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Lexend Deca',
                                                                color:
                                                                Colors.white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),

                              Expanded(
                                  flex: 2,
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            // Generated code for this Container Widget...

                                            // Generated code for this Container Widget...

                                            Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4, 0, 4, 0),
                                                        child: TextFormField(
                                                          controller: status,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Status...',
                                                            hintText:
                                                                'Please Enter Status...',
                                                            hintStyle:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color: Color(
                                                                  0xFF57636C),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            labelStyle:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color: Color(
                                                                  0xFF57636C),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Color(
                                                                0xFF262D34),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text('Next FollowUp Date',   style:
                                                    FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFF262D34),
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                    ),),
                                                    TextButton(

                                                        onPressed: () {
                                                          showDatePicker(
                                                              context: context,
                                                              initialDate: selectedDate1,
                                                              firstDate: DateTime(1901, 1),
                                                              lastDate: DateTime(2100,1)).then((value){

                                                            setState(() {
                                                              datePicked2 = Timestamp.fromDate(DateTime(value.year,value.month,value.day,0,0,0));


                                                              selectedDate1=value;
                                                            });
                                                          });

                                                        },
                                                        child: Text(
                                                          datePicked2==null?'Choose Date': datePicked2.toDate().toString().substring(0,10),
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.blue,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w600,),
                                                        )),

                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 8, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                     if(data['status']==0){
                                                       if (status.text != ''&&datePicked2!=null) {
                                                         bool pressed =
                                                         await alert(
                                                             context,
                                                             'Update This Status...');

                                                         if (pressed) {
                                                           FirebaseFirestore.instance.collection('followUp').add({
                                                             'date': DateTime.now(),
                                                             'next':datePicked2,
                                                             'status': status.text,
                                                             'eId': widget.id,
                                                             'userId': currentUserUid,
                                                             'name':data['name'],
                                                             'done':false,
                                                             'branchId':currentbranchId,
                                                             'rating':0,
                                                           }).then((value) {
                                                             value.update({
                                                               'id':value.id,
                                                             });
                                                             FirebaseFirestore.instance.collection('todo').add({
                                                               'date':datePicked2,
                                                               'status':0,
                                                               'eId':widget.id,
                                                               'name':data['name'],
                                                               'email':data['email'],
                                                               'phone':data['mobile'],
                                                               'userId':currentUserUid,
                                                             });
                                                           });



                                                           showUploadMessage(
                                                               context,
                                                               'Status Updated...');
                                                           setState(() {
                                                             status.text =
                                                             '';
                                                           });
                                                         }
                                                       } else {
                                                         status.text==''?
                                                         showUploadMessage(
                                                             context,
                                                             'Please Enter Status...'):
                                                         showUploadMessage(
                                                             context,
                                                             'Please Choose Date...')
                                                         ;
                                                       }
                                                     }else{
                                                       showUploadMessage(context, 'This Enquiry Already Converted to Student...');

                                                     }


                                                        },
                                                        text: 'Update',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 100,
                                                          height: 40,
                                                          color:
                                                              Color(0xFF4B39EF),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          elevation: 2,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
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

                                            Expanded(
                                              child: StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('followUp')
                                                      .where('eId', isEqualTo: widget.id)
                                                      .orderBy('date', descending: true)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: CircularProgressIndicator(),
                                                      );
                                                    }
                                                    var value = snapshot.data.docs;
                                                    print(value.length.toString()+'    followup doc length????????????');
                                                    return value.length == 0

                                                        ? Container(
                                                          child: Center(
                                                              child: Image.asset(
                                                                  'assets/images/93794-office-illustration.gif'),
                                                            ),
                                                        )
                                                        :SizedBox(
                                                      width: double
                                                          .infinity,
                                                      child: DataTable(
                                                        horizontalMargin:
                                                        5,

                                                        columns: [
                                                          DataColumn(
                                                            label: Container(
                                                              child: Center(
                                                                child: Text(
                                                                    "Date",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold)),
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Container(
                                                              child: Center(
                                                                child: Text(
                                                                    "Status",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold)),
                                                              ),
                                                            ),
                                                          ),

                                                          DataColumn(
                                                            label: Center(
                                                              child: Text(
                                                                  "Next FollowUp",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Center(
                                                              child: Text(
                                                                  "Review",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Center(
                                                              child: Text(
                                                                  "Staff",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Center(
                                                              child: Text(
                                                                  " ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            ),
                                                          ),
                                                        ],
                                                        rows: List
                                                            .generate(
                                                          value.length,
                                                              (index) {
                                                            print(value[index]['rating'].runtimeType);
                                                            print('mmm');

                                                            int ratingStar=value[index]['rating'].toInt();
                                                            return DataRow(
                                                              selected: true,

                                                              color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                              cells: [

                                                                DataCell(
                                                                  Text(
                                                                    value[index]['date'].toDate().toString().substring(0, 16),
                                                                    textAlign: TextAlign.end,
                                                                    style: FlutterFlowTheme.bodyText2.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.black,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                  Text(
                                                                    value[index]['status'],
                                                                    textAlign: TextAlign.end,
                                                                    style: FlutterFlowTheme.bodyText2.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),


                                                                DataCell(
                                                                  Text(
                                                                    value[index]['next'].toDate().toString().substring(0, 10),
                                                                    textAlign: TextAlign.end,
                                                                    style: FlutterFlowTheme.bodyText2.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.black,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),

                                                                DataCell(
                                                                ratingStar==0?
                                                                  Row(
                                                                  children: [
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                  ],
                                                                ):
                                                                 ratingStar==1?
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                    Icon(Icons.star_border,size: 17),
                                                                  ],
                                                                ):
                                                                 ratingStar==2?
                                                                 Row(
                                                                   children: [
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star_border,size: 17),
                                                                     Icon(Icons.star_border,size: 17),
                                                                     Icon(Icons.star_border,size: 17),
                                                                   ],
                                                                 ):
                                                                 ratingStar==3?
                                                                 Row(
                                                                   children: [
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star_border,size: 17),
                                                                     Icon(Icons.star_border,size: 17),
                                                                   ],
                                                                 ):
                                                                 ratingStar==4?
                                                                 Row(
                                                                   children: [
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star_border,size: 17),
                                                                   ],
                                                                 ):
                                                                 Row(
                                                                   children: [
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                     Icon(Icons.star,size: 17,color: Colors.yellow,),
                                                                   ],
                                                                 )


                                                                ),
                                                                DataCell(
                                                                  Text(
                                                                    currentUserIdToName[value[index]['userId']],
                                                                    textAlign: TextAlign.end,
                                                                    style: FlutterFlowTheme.bodyText2.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.black,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataCell(   Row(
                                                                  children: [
                                                                    value[index]['done']==true?
                                                                    FlutterFlowIconButton(
                                                                      borderColor: Colors.transparent,
                                                                      borderRadius: 30,
                                                                      borderWidth: 1,
                                                                      buttonSize: 50,
                                                                      icon: Icon(
                                                                        Icons.check,
                                                                        color: Colors.green,
                                                                        size: 25,
                                                                      ),
                                                                    ):
                                                                    FlutterFlowIconButton(
                                                                      borderColor: Colors.transparent,
                                                                      borderRadius: 30,
                                                                      borderWidth: 1,
                                                                      buttonSize: 50,
                                                                      icon: Icon(
                                                                        Icons.pending,
                                                                        color: Colors.blue,
                                                                        size: 25,
                                                                      ),

                                                                    )
                                                                  ],
                                                                ),),
                                                                // DataCell(Text(fileInfo.size)),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );

                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
