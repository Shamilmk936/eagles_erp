import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/home_page/home.dart';

class AdmissionsSinglePage extends StatefulWidget {
  final String id;
  const AdmissionsSinglePage({Key key, this.id,}) : super(key: key);

  @override
  _AdmissionsSinglePageState createState() => _AdmissionsSinglePageState();
}

class _AdmissionsSinglePageState extends State<AdmissionsSinglePage> {

  DocumentSnapshot student;
  double totalFee=0;
  double yearTotalFee=0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('candidates').doc(widget.id).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){

            return Container(  color: Colors.white,
                child: Center(child: Image.asset('assets/images/loading.gif'),));
          }

          student=snapshot.data;

          List paymentDetails=student['feeDetails'];
          List eduDetails=student['educationalDetails'];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFECF0F5),
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: true,
              title: Text(
                'Student Report',
                style: FlutterFlowTheme.title1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 5,
            ),
            backgroundColor: Color(0xFFECF0F5),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: MediaQuery.of(context).size.width*0.1,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        student['photo']==''?
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.08,

                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png',
                                          ),
                                        ):
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.08,
                                          height: MediaQuery.of(context).size.width*0.08,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:student['photo'],fit: BoxFit.cover,
                                          ),
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width*0.35,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.3,
                                                    child: Text('${student['name']} ${student['lastName']}'
                                                      ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.person,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(student['studentId'])),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.email,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(student['email'])),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.phone,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(student['mobile'])),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: MediaQuery.of(context).size.width*0.1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          color:  Color(0xff062944),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15,top: 5),
                                            child: Text('Personal Details',style:
                                            TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Address',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              // height: MediaQuery.of(context).size.height*0.2,
                                              child: Text(student['address'],
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Date Of Birth',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              // height: MediaQuery.of(context).size.height*0.2,
                                              child: Text(student['dob'].toDate().toString().substring(0,10),
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: MediaQuery.of(context).size.width*0.2,

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height*0.06,
                                          color:  Color(0xff062944),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15,top: 5),
                                            child: Text('Course Details',style:
                                            TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('University',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(UniversityIdToName[student['university']],
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Course',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(CourseIdToName[student['course']],
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Date Of Joining',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(student['date'].toDate().toString().substring(0,10),
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Current Status',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(student['status']==0?'Registered':
                                              student['status']==1?'Completed':
                                              'Drop Out',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: student['status']==0?Colors.black:
                                                    student['status']==1?Colors.green:
                                                    Colors.red
                                                ),),
                                            ),
                                          ],
                                        ),

                                        student['status']==2?
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.1,
                                                  child: Text('Date Of Dropout',style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Text(student['dropOutDate'].toDate().toString().substring(0,10),
                                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.1,
                                                  child: Text('Dropout Reason',style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Text(student['dropOutReason'],
                                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                            :
                                        student['status']==1?
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.1,
                                                  child: Text('Course completed Date',style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Text(student['courseCompletedDate'].toDate().toString().substring(0,10),
                                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                            :Container(height: 0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Batch',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(ClassIdToName[student['classId']]??'',
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: Text('Intake',style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(InTakeIdToName[student['inTake']],
                                                style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.45,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height*0.05,
                                                color:  Color(0xff062944),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 15,top: 5),
                                                  child: Text('Education Details',style:
                                                  TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                  ),
                                                ),
                                              ),
                                              eduDetails.length==0?
                                              Container(
                                                height: MediaQuery.of(context).size.width*0.1,
                                                width: MediaQuery.of(context).size.width*0.45,

                                                child: Center(child: Text('No Data Found...',style: TextStyle(fontWeight: FontWeight.bold),)),
                                              )
                                                  :
                                              ListView.builder(
                                                  itemCount: eduDetails.length,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context,int index) {
                                                    print(eduDetails.isEmpty);
                                                    return Container(
                                                      height: MediaQuery.of(context).size.height*0.05,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.18,
                                                            child: Text(eduDetails[index]['institute'],style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(eduDetails[index]['qualification'],
                                                              style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(eduDetails[index]['year'],
                                                              style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          color:  Color(0xff062944),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15,top: 5),
                                            child: Text('Payment History',style:
                                            TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            ),
                                          ),
                                        ),
                                        paymentDetails.length==0?
                                        Container(
                                          height: MediaQuery.of(context).size.width*0.1,
                                          width: MediaQuery.of(context).size.width*0.45,

                                          child: Center(
                                              child: Text('No Data Found...',style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              )
                                          ),
                                        ) :
                                        ListView.builder(
                                            itemCount: paymentDetails.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context,int index) {
                                              List tuitionFee=paymentDetails[index]['tuitionFee'];

                                              double tu=0;
                                              double ad=0.00;
                                              double un=0.00;
                                              double cn=0.00;

                                              print(tuitionFee);
                                              for(var tuition in tuitionFee){
                                                tu+=tuition['amount'];
                                              }
                                              ad=paymentDetails[index]['admissionFee'];
                                              un=paymentDetails[index]['universityFee'];
                                              cn=paymentDetails[index]['convocationFee'];
                                              yearTotalFee=paymentDetails[index]['currentYearTotalFee'];

                                              totalFee=double.tryParse(ad.toString())+double.tryParse(un.toString())
                                                  +double.tryParse(cn.toString())+double.tryParse(tu.toString());
                                              print(totalFee);


                                              print(paymentDetails.isEmpty);
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 15),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(
                                                              index==0?'First Year':
                                                              index==1?'Second Year':
                                                              'Third Year'
                                                              ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text('Admission Fee',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(ad.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text('University Fee'
                                                              ,style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(un.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text('Convocation Fee',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width*0.1,
                                                            child: Text(cn.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.1,
                                                              child: Center(
                                                                child: Text('Paid Amount',
                                                                  style: FlutterFlowTheme.title1.override(
                                                                    fontFamily: 'Lexend Deca',
                                                                    color: Color(0xFF090F13),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),),
                                                              )),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.1,
                                                              child: Center(
                                                                child: Text(totalFee.toStringAsFixed(2),
                                                                  style: FlutterFlowTheme.title1.override(
                                                                    fontFamily: 'Lexend Deca',
                                                                    color: Color(0xFF090F13),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.1,
                                                              child: Center(
                                                                child: Text('Due Amount',
                                                                  style: FlutterFlowTheme.title1.override(
                                                                    fontFamily: 'Lexend Deca',
                                                                    color: Color(0xFF090F13),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),),
                                                              )),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width*0.1,
                                                              child: Center(
                                                                child: Text((yearTotalFee-totalFee).toStringAsFixed(2),
                                                                  style: FlutterFlowTheme.title1.override(
                                                                    fontFamily: 'Lexend Deca',
                                                                    color: Color(0xFF090F13),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: SizedBox(
                                                          width: double.infinity,
                                                          child: DataTable(
                                                            horizontalMargin: 10,
                                                            columnSpacing: 20,
                                                            columns: [
                                                              DataColumn(
                                                                label: Text(
                                                                  "Date",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 11),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                  "Amount",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 11),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                  "Mode Of Payment",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 11),
                                                                ),
                                                              ),
                                                            ],
                                                            rows: List.generate(
                                                              tuitionFee.length,
                                                                  (index) {

                                                                return DataRow(
                                                                  color: index.isOdd
                                                                      ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                      : MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                                  cells: [
                                                                    DataCell(SelectableText(
                                                                      tuitionFee[index]['date'].toDate().toString().substring(0,10),
                                                                      style: FlutterFlowTheme.bodyText2.override(
                                                                        fontFamily: 'Lexend Deca',
                                                                        color: Colors.black,
                                                                        fontSize: 11,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                    DataCell(Text(
                                                                      tuitionFee[index]['amount'].toString(),
                                                                      style: FlutterFlowTheme.bodyText2.override(
                                                                        fontFamily: 'Lexend Deca',
                                                                        color: Colors.black,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                    DataCell(SelectableText(
                                                                      tuitionFee[index]['modeOfPayment'],
                                                                      style: FlutterFlowTheme.bodyText2.override(
                                                                        fontFamily: 'Lexend Deca',
                                                                        color: Colors.black,
                                                                        fontSize: 11,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),

                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )

                      ],
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
