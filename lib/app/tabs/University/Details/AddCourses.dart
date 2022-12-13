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
import 'AddNewCourse.dart';

List placesList=[];

class AddCourses extends StatefulWidget {
  final String id;
  final List courseList;
  const AddCourses({Key key, this.id, this.courseList,}) : super(key: key);

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchListTileValue=true;
  TextEditingController course;
  TextEditingController tuitionFee;
  TextEditingController intake;
  TextEditingController courseLink;
  TextEditingController scholarShip;
  TextEditingController c5;
  TextEditingController c6;
  TextEditingController c7;
  TextEditingController c8;
  TextEditingController c9;
  TextEditingController c10;
  String name='';


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
    course=TextEditingController();
    tuitionFee=TextEditingController();
    intake=TextEditingController();
    courseLink=TextEditingController();
    scholarShip=TextEditingController();
    c5=TextEditingController();
    c6=TextEditingController();
    c7=TextEditingController();
    c8=TextEditingController();
    c9=TextEditingController();
    c10=TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    print(placesList);
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
                                      fillColor: Colors.white,
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () async {

                                   String name= await     showDialog(context: context,
                                       builder: (buildContext){
                                          return AddNewCourse();
                                        });
                                   if(name!=null){
                                     if(name.contains(name)){
                                       course.text=name;
                                     }
                                     setState(() {

                                     });
                                   }else{
                                     showUploadMessage(context, 'Section was Cancelled...');
                                   }
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
                                                            fontSize: 22,
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
                            'Add Course',
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
                    Row(

                      children: [
                        SizedBox(width: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(data['places'].length, (index) {

                            final place=data['places'][index];
                            return Box(
                              name:place,
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

                                    if(course.text!=''&&tuitionFee.text!=''&&courseLink.text!=''){
                                      if(widget.courseList.contains(courseIdByName[course.text])){

                                        showUploadMessage(context, 'Course Already Exist...');

                                      }else{
                                        bool pressed = await alert(
                                            context,
                                            'Add New Course');

                                        if (pressed) {

                                          List list=[{
                                            'name': courseIdByName[course.text],
                                            'intake':selectedIntakes,
                                            'tuitionFee':tuitionFee.text,
                                            'link':courseLink.text,
                                            'scholarShip':scholarShip.text,
                                            'places':placesList,
                                            'available':true,

                                          }];

                                          snapshot.data.reference.update({
                                            'courseList':FieldValue.arrayUnion(list),
                                            'courses':FieldValue.arrayUnion([courseIdByName[course.text]]),
                                          });
                                          Navigator.pop(context);

                                          setState(() {
                                            placesList=[];
                                          });
                                          showUploadMessage(context, 'New Course Added...');

                                        }
                                      }
                                    }else{

                                      course.text==''?showUploadMessage(context, 'Please Choose Course'):
                                      tuitionFee.text==''?showUploadMessage(context, 'Please Enter Tuition Fee'):
                                      showUploadMessage(context, 'Please Enter Course Link');
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
                                              'Create Course',
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
                        SizedBox(width: 70,),


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

class Box extends StatefulWidget {
  final String name;
  const Box({Key key, this.name}) : super(key: key);

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {

  bool checked=false;

  @override
  Widget build(BuildContext context) {
    // checked=widget.checked;
    return Row(
      children: [
        Text(widget.name),
        Checkbox(value: checked, onChanged: (value){

          if(placesList.contains(widget.name)){
            checked=false;
            placesList.remove(widget.name);

          }else{
            placesList.add(widget.name);
          }

          checked=value;
          setState(() {


          });

        }),
      ],
    );
  }
}

