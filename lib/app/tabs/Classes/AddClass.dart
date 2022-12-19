import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_select/multi_filter_select.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import 'classView.dart';

class AddClass extends StatefulWidget {
  const AddClass({Key key}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {

  TextEditingController course;
  TextEditingController name;
  TextEditingController description;
  TextEditingController intakeCtlr;
  TextEditingController university;
  TextEditingController subject;
  String selectedUniversity;
  List<dynamic> selectedTutors;


  List courseList=[];
  List subjectList=[];
  List<String> selectedCoursesList=[
    'Select Course'
  ];
  getCourses(String selectesUniversity)async{
    universityCourses=[];
   DocumentSnapshot doc= await FirebaseFirestore.instance
        .collection('university')
        .doc(selectesUniversity)
        .get();
    selectedCoursesList.clear();
   if(doc.exists){
     courseList=doc.get('courses');
     if(courseList.isNotEmpty){
       for(var item in courseList){
         selectedCoursesList.add(CourseIdToName[item]);
       }
     }else{
       selectedCoursesList=[
         'Select Course'
       ];
     }

   }else{
     selectedCoursesList=[
       'Select Course'
     ];
   }


    if(mounted){
      setState(() {

      });
    }
  }

  //AVAILABLE

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=10;
  List batchList=[];
  getBatch(){
    FirebaseFirestore.instance
        .collection('class')
    .orderBy('date',descending: true)
    .where('available',isEqualTo: true)
        .limit(limit)
        .snapshots()
        .listen((event) {
      batchList=[];
      for(var students in event.docs){
        batchList.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(batchList.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getBatch();
    } else {
      FirebaseFirestore.instance
          .collection('class')
          .orderBy('date',descending: true)
          .where('available',isEqualTo: true)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        batchList = [];
        for (DocumentSnapshot orders in event.docs) {
          batchList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print('  next  ');
        print(batchList.length.toString()+'                mmmmmm');
        print(lastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getBatch();
    } else {
      FirebaseFirestore.instance
          .collection('class')
          .orderBy('date',descending: true)
          .where('available',isEqualTo: true)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        batchList = [];
        for (DocumentSnapshot orders in event.docs) {
          batchList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(batchList.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }


  //UNAVILABLE
  var pastLastDoc;
  var pastFirstDoc;
  Map <int,DocumentSnapshot> pastLastDocuments={};
  int pastPageIndex=0;
  List pastBatch=[];
  getPastBatch(){
    FirebaseFirestore.instance
        .collection('class')
        .orderBy('date',descending: true)
        .where('available',isEqualTo: false)
        .limit(limit)
        .snapshots()
        .listen((event) {
      pastBatch=[];
      for(var students in event.docs){
        pastBatch.add(students.data());
      }
      pastLastDoc = event.docs.last;
      pastLastDocuments[pastPageIndex] = pastLastDoc;
      pastFirstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(pastBatch.length);
    print('mmmm');
  }
  pNext() {
    pastPageIndex++;
    if (pastLastDoc == null || pastPageIndex == 0) {

      print(pastLastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getPastBatch();
    } else {
      FirebaseFirestore.instance
          .collection('class')
          .orderBy('date',descending: true)
          .where('available',isEqualTo: false)
          .startAfterDocument(pastLastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        pastBatch = [];
        for (DocumentSnapshot orders in event.docs) {
          pastBatch.add(orders.data());
        }
        pastLastDoc = event.docs.last;
        pastLastDocuments[pastPageIndex] = pastLastDoc;
        pastFirstDoc = event.docs.first;
        if (mounted) {
          setState(() {});
        }
        print('  next  ');
        print(pastBatch.length.toString()+'                mmmmmm');
        print(pastLastDoc.toString()+'                jjj');
      });
    }

    setState(() {});
  }
  pPrev() {
    pastPageIndex--;
    if (pastLastDoc == null || pastPageIndex == 0) {
      getPastBatch();
    } else {
      FirebaseFirestore.instance
          .collection('class')
          .orderBy('date',descending: true)
          .where('available',isEqualTo: false)
          .startAfterDocument(pastLastDocuments[pastPageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        pastBatch = [];
        for (DocumentSnapshot orders in event.docs) {
          pastBatch.add(orders.data());
        }
        pastLastDoc = event.docs.last;
        pastLastDocuments[pastPageIndex] = pastLastDoc;
        pastLastDoc = event.docs.first;
        print('  prev  ');
        print(pastBatch.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }
  

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    getBatch();
    getPastBatch();
    super.initState();
    name = TextEditingController();
    description = TextEditingController();
    course = TextEditingController();
    intakeCtlr = TextEditingController();
    university = TextEditingController();
    subject = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECF0F5),
      body : SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Add Batch',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              //add
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 30),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text('Add New Batch',style: FlutterFlowTheme
                                        .bodyText2
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.3,
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
                                      width: MediaQuery.of(context).size.width*0.3,
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
                                          controller: description,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12
                                            ),
                                            hintText: 'Please Enter Description',
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

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width*0.2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                      child:
                                      CustomDropdown.search(
                                        hintText: 'Select university',hintStyle: TextStyle(color:Colors.black),
                                        items: universityList,
                                        controller: university,
                                        // excludeSelected: false,
                                        onChanged: (text){
                                          setState(() {
                                            course.clear();
                                            // selectedCoursesList.clear();

                                            getCourses(UniversityNameToId[text]);
                                          });
                                        },
                                      )
                                  ),
                                ),
                                  SizedBox(width: 10,),
                                  selectedCoursesList.length!=0 && university.text!=''?
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.3,
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
                                        items: selectedCoursesList,
                                        controller: course,
                                        onChanged: (text){
                                          setState(() {

                                          });

                                        },
                                      ),
                                    ),
                                  )
                                  :Container(),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width*0.2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child:
                                          CustomDropdown.search(
                                            hintText: 'Select InTake',hintStyle: TextStyle(color:Colors.black),
                                            items: inTakes,
                                            controller: intakeCtlr,
                                            // excludeSelected: false,
                                            onChanged: (text){
                                              setState(() {

                                              });
                                            },
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Expanded(
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.65,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE6E6E6),
                                          ),
                                        ),
                                        child: MultiFilterSelect(
                                          allItems: tutorList,
                                          initValue: selectedTutors,
                                          hintText: 'select tutors',
                                          selectCallback: (List selectedValue) {
                                            selectedTutors = selectedValue;
                                            setState(() {

                                            });

                                          },
                                        )
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {

                                        if(description.text!=''&&course.text!=''&&intakeCtlr.text!=''&&name.text!=''
                                            &&selectedTutors.isNotEmpty&&selectedUniversity!=''&&subjectList.length!=0){

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
                                            'class': FieldValue.increment(1),

                                          });
                                          int classId = doc['class'];
                                          classId++;

                                          FirebaseFirestore.instance.collection('class')
                                            .doc('C'+classId.toString())
                                              .set({
                                            'date':DateTime.now(),
                                            'name':name.text,
                                            'description':description.text,
                                            'inTake':InTakeNameToId[intakeCtlr.text],
                                            'tutors':selectedTutors,
                                            'university':UniversityNameToId[university.text],
                                            'course':CourseNameToId[course.text],
                                            'available':true,
                                            'students':[],
                                            'id':'C'+classId.toString(),
                                            'subject':subjectList,
                                          });

                                          showUploadMessage(context, 'class added successfully');
                                          description.text='';
                                          course.text='';
                                          intakeCtlr.text='';
                                          university.text='';
                                          selectedTutors.clear();
                                          subjectList.clear();
                                        }else{
                                          description.text==''?showUploadMessage(context, 'Please enter description'):
                                          name.text==''?showUploadMessage(context, 'Please enter name'):
                                          selectedTutors.isEmpty?showUploadMessage(context, 'Please select tutors'):
                                          university.text==''?showUploadMessage(context, 'Please select university'):
                                          intakeCtlr.text==''?showUploadMessage(context, 'Please select intake'):
                                          showUploadMessage(context, 'Please select course');

                                        }

                                      },
                                      text: 'Create',
                                      options: FFButtonOptions(
                                        width: MediaQuery.of(context).size.width*0.1,
                                        height: 50,
                                        color: Colors.teal,
                                        textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.15,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.12,
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
                                          controller: subject,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Subject',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12
                                            ),
                                            hintText: 'Please Enter Subject',
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
                                  InkWell(
                                    onTap: (){
                                     if(subject.text!=''){
                                       subjectList.add(subject.text);
                                       setState(() {

                                       });
                                     }
                                     print(subjectList);
                                     subject.clear();

                                    },
                                    child: CircleAvatar(
                                      maxRadius: 20,
                                      child: Icon(Icons.add,size: 15,color: Colors.white,),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.15,
                                height: MediaQuery.of(context).size.height*0.2,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: subjectList.length,
                                    itemBuilder: (context,  index){
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: InkWell(
                                          onTap: (){
                                            subjectList.removeAt(index);
                                            setState(() {

                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey[350],
                                            ),
                                            height: MediaQuery.of(context).size.height*0.05,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5,top: 5),
                                              child: Text(subjectList[index]),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
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

              //available
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Available batches',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),

              batchList.length==0
                  ?Center(child: CircularProgressIndicator(),)
                  :Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 20,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "University",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Course",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Intake",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Access",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Action",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      batchList.length,
                          (index) {
                        List tutorList=batchList[index]['tutors'];
                        return DataRow(
                          color: index.isOdd
                              ? MaterialStateProperty.all(Colors
                              .blueGrey.shade50
                              .withOpacity(0.7))
                              : MaterialStateProperty.all(
                              Colors.blueGrey.shade50),
                          cells: [
                            DataCell(SelectableText(
                              batchList[index]['name'],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(Text(
                              UniversityIdToName[batchList[index]['university']],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(SelectableText(
                              CourseIdToName[batchList[index]['course']]??'',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(SelectableText(
                              InTakeIdToName[batchList[index]['inTake']],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(
                              FFButtonWidget(
                                onPressed: () async {
                                  bool pressed = await alert(context,
                                      'Do you want to change access?');
                                  if (pressed) {

                                    if(batchList[index]['available'] == true){
                                      FirebaseFirestore.instance
                                          .collection('class')
                                          .doc(batchList[index]['id'])
                                          .update({
                                        'available': !batchList[index]['available'],
                                      });

                                    }else{
                                      FirebaseFirestore.instance
                                          .collection('class')
                                          .doc(batchList[index]['id'])
                                          .update({
                                        'available': !batchList[index]['available'],
                                      });
                                    }

                                  }

                                },
                                text: batchList[index]['available'] == true
                                    ? 'Available'
                                    : 'Unavailable',
                                options: FFButtonOptions(
                                  width: 80,
                                  height: 30,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                      fontFamily: 'Poppins',
                                      color: batchList[index]['available'] == true
                                          ? Colors.teal
                                          : Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                            DataCell(InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClassSinglePage(
                                          classId: batchList[index]['id'],
                                        )));
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.teal,
                                ),
                                child: Center(
                                  child: Text(
                                    'View',
                                    style: FlutterFlowTheme.bodyText2
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )),

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              Row(
                children: [

                  if (pageIndex != 0)
                    ElevatedButton(
                      onPressed: () {
                        prev();
                        setState(() {

                        });
                      },
                      child: Text('Prev'),
                    ),

                  batchList.length<limit||batchList.length==0?
                  Container():
                  ElevatedButton(
                    onPressed: () {
                      next();
                      setState(() {

                      });
                    },
                    child: Text('Next'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),

              //unavilable
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Unavailable batches',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),

              pastBatch.length==0
                  ?Center(child: CircularProgressIndicator(),)
                  :Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 20,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "University",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Course",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Intake",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Access",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Action",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      pastBatch.length,
                          (index) {
                        List tutorList=pastBatch[index]['tutors'];
                        return DataRow(
                          color: index.isOdd
                              ? MaterialStateProperty.all(Colors
                              .blueGrey.shade50
                              .withOpacity(0.7))
                              : MaterialStateProperty.all(
                              Colors.blueGrey.shade50),
                          cells: [
                            DataCell(SelectableText(
                              pastBatch[index]['name'],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(Text(
                              UniversityIdToName[pastBatch[index]['university']],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(SelectableText(
                              CourseIdToName[pastBatch[index]['course']]??'',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(SelectableText(
                              InTakeIdToName[pastBatch[index]['inTake']],
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            DataCell(
                              FFButtonWidget(
                                onPressed: () async {
                                  bool pressed = await alert(context,
                                      'Do you want to change access?');
                                  if (pressed) {

                                    if(pastBatch[index]['available'] == true){
                                      FirebaseFirestore.instance
                                          .collection('class')
                                          .doc(pastBatch[index]['id'])
                                          .update({
                                        'available': !pastBatch[index]['available'],
                                      });

                                    }else{
                                      FirebaseFirestore.instance
                                          .collection('class')
                                          .doc(pastBatch[index]['id'])
                                          .update({
                                        'available': !pastBatch[index]['available'],
                                      });
                                    }

                                  }

                                },
                                text: pastBatch[index]['available'] == true
                                    ? 'Available'
                                    : 'Unavailable',
                                options: FFButtonOptions(
                                  width: 80,
                                  height: 30,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                      fontFamily: 'Poppins',
                                      color: pastBatch[index]['available'] == true
                                          ? Colors.teal
                                          : Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                            DataCell(InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClassSinglePage(
                                          classId: pastBatch[index]['id'],
                                        )));
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.teal,
                                ),
                                child: Center(
                                  child: Text(
                                    'View',
                                    style: FlutterFlowTheme.bodyText2
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )),

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              Row(
                children: [

                  if (pastPageIndex != 0)
                    ElevatedButton(
                      onPressed: () {
                        pPrev();
                        setState(() {

                        });
                      },
                      child: Text('Prev'),
                    ),

                  pastBatch.length<limit||pastBatch.length==0?
                  Container():
                  ElevatedButton(
                    onPressed: () {
                      pNext();
                      setState(() {

                      });
                    },
                    child: Text('Next'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),

              SizedBox(height: 30,)

            ],
          ),
        ),
      )
    );
  }
}

//course dropdown and list added