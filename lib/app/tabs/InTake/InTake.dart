
import 'package:smile_erp/auth/auth_util.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';

import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';


class AddIntakeWidget extends StatefulWidget {
  const AddIntakeWidget({Key key}) : super(key: key);

  @override
  _AddIntakeWidgetState createState() => _AddIntakeWidgetState();
}

class _AddIntakeWidgetState extends State<AddIntakeWidget> {
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate1 = DateTime.now();
  DateTime startingDate ;
  DateTime endingDate ;


bool loaded=false;

getIntakes()async{
  QuerySnapshot snap =await FirebaseFirestore.instance.collection('intakes')
      .where('intake',isEqualTo: startingDate)
      .where('end',isEqualTo: endingDate)
      .get();

  if(snap.docs.isEmpty){
    bool pressed=await alert(context, 'Do you want to Add InTake...?');


    if(pressed){
      FirebaseFirestore.instance.collection('intakes').add({
        'available':true,
        'created_date':DateTime.now(),
        'end':endingDate,
        'intake':startingDate,
        'intakeName':'${dateTimeFormat('yMMM',startingDate)}-${dateTimeFormat('yMMM',endingDate)}',
        'userId':currentUserUid,
        'userEmail':currentUserEmail,
      }).then((value){
        value.update({
          'intakeId':value.id,
        });
      });
      setState(() {
        startingDate=null;
      });
      showUploadMessage(context, 'New Intake Created...');
    }
  }else{
    showUploadMessage(context, 'Intake Already Added...');
  }
      if(mounted){
        setState(() {

        });
      }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 1, 5),
                                  lastDate: DateTime(DateTime.now().year + 4, 12),
                                  initialDate: selectedDate1,
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      startingDate = date;
                                      print(startingDate.toString().substring(0,10));
                                    });
                                  }
                                });

                                },
                              text: startingDate==null?'Start': dateTimeFormat('yMMM', startingDate),
                              options: FFButtonOptions(
                                width: 150,
                                height: 40,
                                color:
                                Colors.teal,
                                textStyle: FlutterFlowTheme
                                    .subtitle2
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 1, 5),
                                  lastDate: DateTime(DateTime.now().year + 4, 12),
                                  initialDate: selectedDate1,
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      endingDate = date;
                                      print(endingDate.toString().substring(0,10));
                                    });
                                  }
                                });

                                },
                              text: endingDate==null?'End': dateTimeFormat('yMMM', endingDate),
                              options: FFButtonOptions(
                                width: 150,
                                height: 40,
                                color:
                                Colors.teal,
                                textStyle: FlutterFlowTheme
                                    .subtitle2
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                            SizedBox(width: 100,),

                            FFButtonWidget(
                              onPressed: () async {
                                if(startingDate!=null&&endingDate!=null){
                                  getIntakes();

                                }else{
                                  startingDate==null?showUploadMessage(context, 'Please Choose starting Date')
                                  :showUploadMessage(context, 'Please choose ending Date');
                                }

                              },
                              text: 'Add',
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color:
                                FlutterFlowTheme.primaryColor,
                                textStyle: FlutterFlowTheme
                                    .subtitle2
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
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
                    ),
                  ),
                ],
              ),
            ),

           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Text('Available Intakes', style: FlutterFlowTheme
                 .subtitle1
                 .override(
               fontFamily: 'Lexend Deca',
               color: Color(0xFF090F13),
               fontSize: 18,
               fontWeight: FontWeight.w600,
             ),),
           ),

           StreamBuilder<QuerySnapshot>(
             stream: FirebaseFirestore.instance.collection('intakes')
                 .where('available',isEqualTo: true)
                 .snapshots(),
             builder: (context, snapshot) {
               if(!snapshot.hasData){
                 return Center(child: CircularProgressIndicator(),);
               }
               List data=snapshot.data.docs;
               data.sort((a,b){
                 return a["intake"].compareTo(b["intake"]);
               });


               return Wrap(children: List.generate(data.length, (index) {
                 if(loaded==false){
                   loaded=true;
                   switchListTileValue=data[index]['available'];
                 }
                 return  Intakes(
                   name:data[index]['intakeName'],
                   date: data[index]['intake'].toDate(),
                   available: data[index]['available'],
                   id: data[index].id,
                 );
               }),);
             }
           ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Past Intakes', style: FlutterFlowTheme
                  .subtitle1
                  .override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('intakes')
                    .where('available',isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  List data=snapshot.data.docs;
                  data.sort((a,b){
                    return a["intake"].compareTo(b["intake"]);
                  });
                  return Wrap(children: List.generate(data.length, (index) {
                    if(loaded==false){
                      loaded=true;
                      switchListTileValue=data[index]['available'];
                    }
                    return  Intakes(
                      name:data[index]['intakeName'],
                      date: data[index]['intake'].toDate(),
                      available: data[index]['available'],
                      id: data[index].id,
                    );
                  }),);
                }
            ),
          ],
        ),
      ),
    );
  }
}

class Intakes extends StatefulWidget {
  final DateTime date;
  final bool available;
  final String id;
  final String name;
  const Intakes({Key key, this.date, this.available, this.id, this.name}) : super(key: key);

  @override
  State<Intakes> createState() => _IntakesState();
}

class _IntakesState extends State<Intakes> {
  bool available=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    available=widget.available;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      child: Container(
        width: MediaQuery.of(context).size.width*0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x2E000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarCheck,
                      color: Colors.black,
                      size: 22,
                    ),
                    SizedBox(width: 10,),
                    Text(
                    widget.name
                      ,style: FlutterFlowTheme
                          .subtitle1
                          .override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SwitchListTile(
                    value: available,
                    onChanged: (newValue) {

                      FirebaseFirestore.instance.collection('intakes').doc(widget.id).update({
                        'available':newValue,
                      });
                      setState(() {
                        available = newValue;
                    });
                      },

                    tileColor: Color(0xFFF5F5F5),
                    activeColor: Color(0xFF37BB8D),
                    dense: false,
                    controlAffinity:
                    ListTileControlAffinity.trailing,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

