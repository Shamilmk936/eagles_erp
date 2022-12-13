import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../pages/home_page/home.dart';

List editPlaceList=[];

class EditUniversityCourse extends StatefulWidget {
  final String id;
  final String name;
  final String tuitionFee;
  final List intake;
    final Map courseList;
    final List fullCourse;
    final List fullCourseMap;
  const EditUniversityCourse({Key key, this.id, this.name, this.courseList, this.fullCourse, this.fullCourseMap, this.intake, this.tuitionFee}) : super(key: key);

  @override
  _EditUniversityCourseState createState() => _EditUniversityCourseState();
}

class _EditUniversityCourseState extends State<EditUniversityCourse> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchListTileValue=true;
  TextEditingController course;
  TextEditingController intake;
  TextEditingController tuitionFee;
  TextEditingController courseLink;
  TextEditingController scholarShip;
  TextEditingController c5;
  TextEditingController c6;
  TextEditingController c7;
  TextEditingController c8;
  TextEditingController c9;
  TextEditingController c10;
  String name='';
  List fullCourse=[];

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
    // TODO: implement initState
    super.initState();
    getIntakes();
    for(var data in widget.intake){
      selectedIntakes.add(data);
    }
    fullCourse=widget.fullCourse;
    switchListTileValue=widget.courseList['available'];
    course=TextEditingController(text: widget.name);
    tuitionFee=TextEditingController(text: widget.courseList['tuitionFee']);
    courseLink=TextEditingController(text: widget.courseList['link']);
    scholarShip=TextEditingController(text: widget.courseList['scholarShip']);
    c5=TextEditingController();
    c6=TextEditingController();
    c7=TextEditingController();
    c8=TextEditingController();
    c9=TextEditingController();
    c10=TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: countryMap.length==0?Center(child: Image.asset('assets/images/loading.gif'),):StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('university').doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Image.asset('assets/images/loading.gif'),);
            }
            var data=snapshot.data;
            return
              SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: Stack(
                      alignment: AlignmentDirectional(0, 1),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: CachedNetworkImage(
                            imageUrl:
                            data.get('banner')==''?data.get('logo'):data.get('banner'),
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 44, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x520E151B),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 8,
                                    borderWidth: 1,
                                    buttonSize: 40,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Color(0xFF57636C),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 4,
                                sigmaY: 10,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 170,
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
                                                width: 100,
                                                height: 80,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: data.get('logo'),
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
                                                        data.get('name'),
                                                        style: FlutterFlowTheme
                                                            .title2
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 26,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        data.get('email'),
                                                        style: FlutterFlowTheme
                                                            .subtitle2
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFF31BFAE),
                                                          fontSize: 16,
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
                                                print('IconButton pressed ...');
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
                                                print('IconButton pressed ...');
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
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0, 8, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                // Generated code for this CircleImage Widget...
                                                Container(
                                                  width: 100,
                                                  height: 80,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: countryMap[data['country']]['logo'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                Text(
                                                  countryMap[data['country']]['name'],
                                                  style: FlutterFlowTheme
                                                      .title2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Edit Course',
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF57636C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Generated code for this userList_5 Widget...
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Text('Please Select Course',  style: FlutterFlowTheme
                            .bodyText1
                            .override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold,
                        ),),
                        SizedBox(width: 10,),
                        Expanded(
                          child: SwitchListTile(
                            value: switchListTileValue ??= true,
                            onChanged: (newValue) => setState(() => switchListTileValue = newValue),
                            title: Text(
                              'Enable',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                            tileColor: Colors.white,
                            activeColor: Colors.grey,
                            activeTrackColor: Colors.teal,
                            dense: false,

                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        )

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 50,),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(data['places'].length, (index) {
                            final place=data['places'][index];
                            return EditBox(
                              name:place,
                              place: widget.courseList['places'],
                            );
                          })
                      ),
                      Expanded(
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      width: 330,
                                      height: 60,
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
                                        hintText: 'Select Course',
                                        items: courses,
                                        controller: course,
                                        excludeSelected: false,
                                        onChanged: (text){
                                          setState(() {


                                          });

                                        },

                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: MultiFilterSelect(
                                          allItems: intakes,
                                          initValue: selectedIntakes,
                                          hintText: 'Select Intakes',
                                          selectCallback: (List selectedValue) =>
                                          selectedIntakes = selectedValue,
                                        )
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
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
                                          controller: courseLink,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Course Link',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Please Enter Course Link',
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
                                          controller: scholarShip,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Scholar Ship',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Please Enter Scholar Ship Amount',
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 50,),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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

                                  int i=0;
                                  for(int k=0;k<fullCourse.length;k++){
                                    if(fullCourse[k]['name']==courseIdByName[widget.name]&&fullCourse[k]['tuitionFee']==widget.tuitionFee){
                                      i=k;
                                      break;
                                    }
                                  }
                                  fullCourse.removeAt(i);

                                  print(fullCourse.length);

                                  fullCourse.insert(i,
                                      {
                                        'name': courseIdByName[course.text],
                                        'intake':selectedIntakes,
                                        'tuitionFee':tuitionFee.text,
                                        'link':courseLink.text,
                                        'scholarShip':scholarShip.text,
                                        'places':editPlaceList,
                                        'available':switchListTileValue,


                                      });


                                  setState(() {

                                  });



                                  if(widget.fullCourseMap.contains(courseIdByName[course.text])&&widget.name!=course.text){

                                    showUploadMessage(context, 'Course Already Exist...');
                                  }else{
                                    bool pressed = await alert(
                                        context,
                                        'Update Course Details');

                                    if (pressed) {

                                      if(widget.name!=course.text){
                                        snapshot.data.reference.update({
                                          'courses':FieldValue.arrayRemove([courseIdByName[widget.name]]),
                                          'courseList':fullCourse,
                                        });
                                           snapshot.data.reference.update({
                                          'courses':FieldValue.arrayUnion([courseIdByName[course.text]]),
                                        });

                                      }else{

                                        snapshot.data.reference.update({
                                          'courseList':fullCourse,
                                        });

                                      }

                                      Navigator.pop(context);
                                      showUploadMessage(context, 'Course Details Updated...');
                                    }
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

                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional
                                              .fromSTEB(8,
                                              0, 0, 0),
                                          child: Text(
                                            'Update Course Details',
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
                      ),

                    ],
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}

class EditBox extends StatefulWidget {
  final String name;
  final List place;
  const EditBox({Key key, this.name, this.place}) : super(key: key);

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {

  bool checked=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editPlaceList=widget.place;

    if(editPlaceList.contains(widget.name)){
      checked=true;
    }else{
      checked=false;
    }
  }

  @override
  Widget build(BuildContext context) {


    print(editPlaceList);

    return Row(
      children: [
        Text(widget.name),
        Checkbox(value: checked, onChanged: (value){

          if(editPlaceList.contains(widget.name)){
            checked=false;
            editPlaceList.remove(widget.name);

          }else{
            editPlaceList.add(widget.name);
          }

          checked=value;
          setState(() {
            print(editPlaceList);


          });

        }),
      ],
    );
  }
}
