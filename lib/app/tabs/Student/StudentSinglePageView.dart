
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_pickers/country.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smile_erp/backend/backend.dart';
import 'package:smile_erp/backend/schema/index.dart';
import 'package:smile_erp/flutter_flow/flutter_flow_util.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import 'package:flutter/services.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'createPopup.dart';

 var documents;

class StudentSinglePageView extends StatefulWidget {
  final String id;
  const StudentSinglePageView({Key key, this.id,}) : super(key: key);

  @override
  _StudentSinglePageViewState createState() =>
      _StudentSinglePageViewState();
}

class _StudentSinglePageViewState
    extends State<StudentSinglePageView> {

  int selectedIndex=0;
  List items=[];
  bool loaded=false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //PERSONAL DETAILS

  List<String> personalKeys =[
    'name',
    'lastName',
    'email',
    'mobile',
    'dob',
    'gender',
    'place',
    'address',
    'educationalDetails'
  ];
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController email;
  String countryCode='IN';
  String phoneCode='+91';
  TextEditingController mobile;
  TextEditingController studentPlace;
  TextEditingController address;
  String gender;
  DateTime dateOfBirth;
  String uploadedFileUrl = '';
  List edu=[];

  //COURSE
  TextEditingController university;
  TextEditingController course;
  TextEditingController classControlller;
  TextEditingController intakeCtlr;

  List courseList=[];
  String selectedUniversity;
  List<String> universityCourse=['Select Course'];
  getCourses(String selectedUniversity)async{
print('ccccccccccc');
    universityCourse=[];
    DocumentSnapshot doc= await FirebaseFirestore.instance
        .collection('university')
        .doc(selectedUniversity)
        .get();
    courseList=doc.get('courses');
    print(courseList);
    for(var item in courseList){
      universityCourse.add(CourseIdToName[item]);
    }
    print(universityCourse);
    print('Jjjjjjjjjjjjjjj');
    if(mounted){
      setState(() {

      });
    }
  }

  List<String> classList=['select batch'];
  String selectedCourse;
  String selectedClass;
  String selectedIntake;
  String currentYear;
  getClass(String selectedUniversity,String selectedCourse) {
    print('  CLASS FUNCTION   ');
    print(CourseIdToType[selectedCourse]);
    FirebaseFirestore.instance
        .collection('class')
        .where('university', isEqualTo: selectedUniversity)
        .where('course', isEqualTo: selectedCourse)
        .where('available', isEqualTo: true)
        .snapshots()
        .listen((event) {
      classList = [];
      for (var item in event.docs) {
        classList.add(item.get('name'));
        ClassIdToName[item.id] = item.get('name');
        ClassNameToId[item.get('name')] = item.id;
      }
      print(classList);
      setState(() {

      });
    });
  }

  //EDUCATION
  TextEditingController qualification;
  TextEditingController institute;
  String yearOfPassout;

  //Fee Details
  TextEditingController feepaid;
  TextEditingController discount;
  TextEditingController reason;
  TextEditingController pay;
  double discountAmount=0.0;
  List feeList=[];
  double paidFee=0;
  double yearTotalFee=0;


  // DOCUMENTS
  List uploadDocument=[];
  PlatformFile pickFile;
  UploadTask uploadTask;
  Future selectFileToMessage(String name)async{

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

  Future uploadFileToFireBase(String name, fileBytes,String ext) async {

    uploadTask= FirebaseStorage.instance.ref('uploads/${widget.id}-$name.$ext').putData(fileBytes);
    final snapshot= await  uploadTask.whenComplete((){});
    final urlDownlod = await  snapshot.ref.getDownloadURL();

    // List uploadDocument=[];
    // uploadDocument.add(urlDownlod);
    dynamic data={};
   DocumentSnapshot doc= await FirebaseFirestore.instance.collection('candidates').doc(student.id).get();
   data=doc.get('documents');
   data.addAll({'$name':urlDownlod,});

      FirebaseFirestore.instance.collection('candidates').doc(student.id).update({
        'documents': data,
      });

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {

    });
  }

  List Ug=['Signature','SSLC','Plus two','Aadhaar/Passport'];
  List Pg=['Signature','SSLC','Plus two','Aadhaar/Passport','Degree certificate','Degree marksheet'];
  List SSLC=['Signature','8 th marksheet/self attested certificate','Aadhaar/Passport'];
  List plusTwo=['Signature','SSLC','Aadhaar/Passport'];

  Map studentDocument={};
  CheckDocuments(){
    FirebaseFirestore.instance.collection('candidates').doc(widget.id).snapshots().listen((event) {
       studentDocument=event.get('documents');
    });
  }


  //FEE
  Timestamp feePaidDate;
  Timestamp dueDate;
  String dueDateView;
  DateTime selectedDate = DateTime.now();

  bool radioSelected1 = true;
  bool cash=false;
  bool bank=false;
  String radioval='';


  void rejectAndRefund(
      String course,
      List emailList,
      String name,
      String intake
      ) async {

    print('hhhhhhh');
    FirebaseFirestore.instance.collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body><p>Helo $name</p>'
          '<p></p>'
          '<p>Your admission for <var>$course</var> for the academic year <var>$intake</var> with Live To Smile Digital Academy is Rejected.</p>'
          '<p>Amount will be refunded with in 7 days</p>'
          '<p></p>'
          '<p></p>'
          '<p></p>'
          '<p>Coordinator-<var>$course</var></p>'
          '<p></p>'
          '</body>',
      'emailList':emailList,
      'status':'Admission request rejected'
    });

    print('eeee');
  }

  void reject(
      String course,
      List emailList,
      String name,
      String intake
      ) async {

    FirebaseFirestore.instance.collection('mail')
        .add({
      'date':DateTime.now(),
      'html':
      '<body><p>Helo $name</p>'
          '<p></p>'
          '<p>Your admission for <var>$course</var> for the academic year <var>$intake</var> with Live To Smile Digital Academy is Rejected.</p>'
          '<p>Request again</p>'
          '<p></p>'
          '<p></p>'
          '<p></p>'
          '<p>Coordinator-<var>$course</var></p>'
          '<p></p>'
          '</body>',
      'emailList':emailList,
      'status':'Admission request rejected'
    });

    print('eeee');
  }


  // REFUND

  Future<void> generate_ODID(String id) async {

    print(id);

    final client = HttpClient();
    final request =
    await client.postUrl(Uri.parse('https://api.razorpay.com/v1/payments/$id/refund'));
    request.headers.set(
        HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    print(2);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${'rzp_live_C190kQus1hA6p6'}:${'OUikvDm9CsPAJq6LjYaGCIOa'}'));
    print(3);
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);


    // request.add(utf8.encode(json.encode(orderOptions)));
    print(4);
    final response = await request.close();

    print(5);
    response.transform(utf8.decoder).listen((contents) async {
      print(6);
      print('Response : '+contents);
    });

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

  //CLASSESS

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=15;
  List classess=[];
  getStudentClasses(String selectedClass){
    FirebaseFirestore.instance
        .collection('zoomClass')
        .orderBy('scheduled', descending: true)
        .where('batch',isEqualTo: selectedClass)
        .limit(limit)
        .snapshots()
        .listen((event) {
      classess=[];
      for(var students in event.docs){
        classess.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(classess.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getStudentClasses(selectedClass);
    } else {
      FirebaseFirestore.instance
          .collection('zoomClass')
          .orderBy('scheduled', descending: true)
          .where('batch',isEqualTo: selectedClass)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        classess = [];
        for (DocumentSnapshot orders in event.docs) {
          classess.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});print('  next  ');
          print(classess.length.toString()+'                mmmmmm');
          print(lastDoc.toString()+'                jjj');
        }

      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getStudentClasses(selectedClass);
    } else {
      FirebaseFirestore.instance
          .collection('zoomClass')
          .orderBy('scheduled', descending: true)
          .where('batch',isEqualTo: selectedClass)
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        classess = [];
        for (DocumentSnapshot orders in event.docs) {
          classess.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(classess.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Personal Details
    firstName=TextEditingController();
    lastName=TextEditingController();
    email=TextEditingController();
    mobile=TextEditingController();
    studentPlace=TextEditingController();
    address=TextEditingController();
    qualification=TextEditingController();
    institute=TextEditingController();
    feepaid=TextEditingController();

    //Course
    university=TextEditingController();
    classControlller=TextEditingController();
    intakeCtlr=TextEditingController();
    course=TextEditingController();

    //Education
    reason=TextEditingController();

    //feeDetails
    pay=TextEditingController();

    CheckDocuments();
  }
  @override

  DocumentSnapshot student;

  launchURL(String urls) async {
    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List FeeStruct=[];
  getUniversityFeeStrct(String selecteduniversityId,String selectedCourseId) async {
    DocumentSnapshot doc=await FirebaseFirestore.instance
        .collection('university')
        .doc(selecteduniversityId)
        .get();
    List courseList=doc.get('courseList');
     for(var course in courseList){
       if(course['courseId']==selectedCourseId){
         FeeStruct.add(course);
       }
     }
     print(FeeStruct);

  }

  @override
  Widget   build(BuildContext context) {
    Widget _buildDropdownItem(Country country) => Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0,),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('candidates').doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){

          return Container(  color: Colors.white,
              child: Center(child: Image.asset('assets/images/loading.gif'),));
        }

        student=snapshot.data;

        feeList=student['feeDetails']??[];
        paidFee=0.0;
        DateTime duedate = student['dueDate'].toDate();
        Map<String,dynamic> stData =snapshot.data.data();
       bool PD =true;
       for(String key in personalKeys){
         if(stData[key]==null||stData[key]==""||edu.length==0){
           PD =false;
           break;
         }
       }

        dateOfBirth=student['dob'].toDate();
        discountAmount = double.tryParse(student['discount'].toString());
        edu=student['educationalDetails']??[];
        items=student['form'];
        dueDateView=student['dueDate'].toDate().toString().substring(0,10);

          uploadedFileUrl=student['photo'];


         if(CourseIdToType[student['course']]=='PG'){
           uploadDocument=Pg;
         }else if(CourseIdToType[student['course']]=='UG'){
           uploadDocument=Ug;
         }else if(CourseIdToType[student['course']]=='SSLC'){
           uploadDocument=SSLC;
         }else{
           uploadDocument=plusTwo;
         }

        if(loaded==false) {
          loaded=true;

          email.text = student['email'];
          countryCode = student['countryCode'];
          phoneCode = student['phoneCode'];
          studentPlace.text = student['place']??'';
          gender = student['gender']??'';
          firstName.text = student['name'];
          lastName.text = student['lastName'];
          address.text = student['address'];
          mobile.text = student['mobile'];

          //COURSE
          university.text=UniversityIdToName[student['university']];
          selectedUniversity=student['university'];
          getCourses(selectedUniversity);
          course.text=CourseIdToName[student['course']];
          selectedCourse=student['course'];
          getClass(selectedUniversity, selectedCourse);
          classControlller.text=ClassIdToName[student['classId']];
          selectedClass=student['classId'];
          getStudentClasses(selectedClass);
          intakeCtlr.text=InTakeIdToName[student['inTake']];

        }

        return Scaffold(
          key: scaffoldKey,
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
          backgroundColor: Color(0xFFECF0F5),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
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
                                uploadedFileUrl==''?
                                Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                    child: CachedNetworkImage(
                                    imageUrl: 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png',
                                  ),
                                ):
                                Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                    child: CachedNetworkImage(
                                    imageUrl:student['photo'],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                        child: Text(
                                          student.id,
                                          style: FlutterFlowTheme
                                              .title3
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF090F13),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                        child: Text(
                                          student['name'],
                                          style: FlutterFlowTheme
                                              .title3
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF090F13),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                        child: Text(
                                          student['email'],
                                          style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF4B39EF),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20,),

                                SingleChildScrollView(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(items.length, (index) {
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

                                                  index<2?

                                                      (index==0&&PD) ?
                                                  Icon(
                                                    Icons.done_all_outlined,
                                                    color:
                                                    selectedIndex==index?Colors.white: Color(0xFF43B916),
                                                    size: 30,
                                                  ):
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    color:selectedIndex==index?Colors.white: Colors.red,
                                                    size: 25,
                                                  ):Container(),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0, 8, 0, 0),
                                                    child: Text(
                                                      items[index]['name'],
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

                //PERSONAL DETAILS
                selectedIndex == 0
                    ? Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30, 10, 30, 5),
                          child: Text(
                            'Personal Details',
                            style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),

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
                                    print(
                                        "ssssssssssssssssssssssssssssssssssssssssssssssssssssssss");

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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30, 10, 30, 5),
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
                                        hintText:
                                        'Please Enter First Name',
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
                              SizedBox(
                                width: 20,
                              ),
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
                                        hintText:
                                        'Please Enter Last Name',
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
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      validator: (email) {
                                        if (email.isEmpty) {
                                          return "Enter your email";
                                        } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                            .hasMatch(email)) {
                                          return "Email not valid";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: email,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Please Enter Email',
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30, 10, 30, 5),
                          child: Row(
                            children: [

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
                              SizedBox(width: 20,),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime selected = await showDatePicker(
                                      fieldHintText: 'dd/mm/yyyy',
                                      // locale: Locale('in'),

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
                                        child:Center(child:dateOfBirth==null?Text('please choose'):Text("${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}",
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
                              SizedBox(width: 20,),
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
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: FlutterFlowDropDown(
                                      initialOption: gender ?? 'Male',
                                      options: ['Male', 'Female'],
                                      onChanged: (val) => setState(() {
                                        gender = val;
                                      }),
                                      width: 180,
                                      height: 50,
                                      textStyle: FlutterFlowTheme
                                          .bodyText1
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      hintText: 'Please select...',
                                      fillColor: Colors.white,
                                      elevation: 0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0,
                                      borderRadius: 8,
                                      margin: EdgeInsetsDirectional
                                          .fromSTEB(12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30, 10, 30, 5),
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
                                      keyboardType:
                                      TextInputType.multiline,
                                      controller: address,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                        labelStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText:
                                        'Please Enter Address',
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
                              SizedBox(
                                width: 20,
                              ),
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
                                      controller: studentPlace,
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

                            ],
                          ),
                        ),

//COURSE DETAILS
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30, 5, 30, 20),
                            child: Text(
                              'Course Details',
                              style: FlutterFlowTheme.bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                          child: Row(
                            children: [
                              //education board
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

                              //course
                              selectedUniversity!=null&& universityCourse.isNotEmpty?
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
                                      items: universityCourse,
                                      controller: course,
                                      onChanged: (text){
                                        selectedCourse=CourseNameToId[course.text];
                                        classControlller.clear();
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

                              //batch
                              selectedUniversity!=null&& universityCourse.isNotEmpty
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

                              //intake
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

                            ],
                          ),
                        ),
//UPDATE BUTTON
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  bool pressed = await alert(context,
                                      'Update Personal Details');
                                  if (pressed) {
                                    student.reference.update({
                                      'name': firstName.text,
                                      'lastName': lastName.text,
                                      'email': email.text,
                                      'mobile': mobile.text,
                                      'countryCode': countryCode,
                                      'phoneCode': phoneCode,
                                      'dob': dateOfBirth,
                                      'gender': gender,
                                      'address': address.text,
                                      'place': studentPlace.text,
                                      'photo': uploadedFileUrl,
                                      'university':selectedUniversity,
                                      'course':selectedCourse,
                                      'classId':selectedClass,
                                      'inTake':selectedIntake,
                                    }).then((value) {
                                      loaded = false;
                                      setState(() {});
                                    });
                                    showUploadMessage(context,
                                        'Personal Details updated...');
                                  }
                                },
                                text: 'Update',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: Colors.teal,
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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

//EDUCATION
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30, 5, 30, 20),
                            child: Text(
                              'Education Details',
                              style: FlutterFlowTheme.bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30, 5, 30, 5),
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
                                            fontFamily:
                                            'Montserrat',
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 12),
                                        hintText:
                                        'Please Enter Qualification',
                                        hintStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                            fontFamily:
                                            'Montserrat',
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 12),
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
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                                            fontFamily:
                                            'Montserrat',
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 12),
                                        hintText:
                                        'Please Enter institute name',
                                        hintStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                            fontFamily:
                                            'Montserrat',
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 12),
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
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate:
                                        DateTime(1901, 1),
                                        lastDate: DateTime(2300, 1))
                                        .then((value) {
                                      setState(() {
                                        DateFormat("d-MM-y")
                                            .format(value);

                                        Timestamp passoutYear =
                                        Timestamp.fromDate(DateTime(
                                            value.year,
                                            value.month,
                                            value.day,
                                            0,
                                            0,
                                            0));

                                        yearOfPassout = dateTimeFormat(
                                            'd-MMM-y',
                                            passoutYear.toDate());
                                        selectedDate = value;
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
                                    child: yearOfPassout == null ||
                                        yearOfPassout == ''
                                        ? Center(
                                      child: Center(
                                        child: Text(
                                          'choose pass out year',
                                          style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily:
                                              'Montserrat',
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                        : Center(
                                      child: Text(yearOfPassout),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 8, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    if (qualification.text != '' &&
                                        institute.text != '' &&
                                        yearOfPassout != '') {
                                      List abc = [];
                                      abc.add({
                                        'qualification':
                                        qualification.text,
                                        'institute': institute.text,
                                        'year': yearOfPassout,
                                      });
                                      print(abc.toString());
                                      FirebaseFirestore.instance
                                          .collection('candidates')
                                          .doc(widget.id)
                                          .update({
                                        'educationalDetails':
                                        FieldValue.arrayUnion(abc),
                                      });
                                      showUploadMessage(context,
                                          'education details added successfully');

                                      qualification.text = '';
                                      institute.text = '';
                                      yearOfPassout = '';
                                    } else {
                                      qualification.text == ''
                                          ? showUploadMessage(context,
                                          'Please Enter Qualification')
                                          : institute.text == ''
                                          ? showUploadMessage(
                                          context,
                                          'Please Enter institute')
                                          : showUploadMessage(
                                          context,
                                          'Please Enter Year');
                                    }
                                  },
                                  text: 'Add',
                                  options: FFButtonOptions(
                                    width: 80,
                                    height: 40,
                                    color: Colors.teal,
                                    textStyle: FlutterFlowTheme
                                        .subtitle2
                                        .override(
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
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          child: edu.length == 0
                              ? Center(
                              child: Text(
                                'no data found....',
                                style: FlutterFlowTheme.bodyText2
                                    .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ))
                              : DataTable(
                            horizontalMargin: 12,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "Sl No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text("Qualification",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 12)),
                              ),
                              DataColumn(
                                label: Text("Institute",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 12)),
                              ),
                              DataColumn(
                                label: Text("Year",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 12)),
                              ),
                              DataColumn(
                                label: Text("",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold)),
                              ),
                            ],
                            rows: List.generate(
                              edu.length,
                                  (index) {
                                final history = edu[index];

                                return DataRow(
                                  color: index.isOdd
                                      ? MaterialStateProperty.all(
                                      Colors.blueGrey.shade50
                                          .withOpacity(0.7))
                                      : MaterialStateProperty.all(
                                      Colors
                                          .blueGrey.shade50),
                                  cells: [
                                    DataCell(Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 12))),
                                    DataCell(Text(
                                        history['qualification'],
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 12))),
                                    DataCell(Text(
                                        history['institute'] ??
                                            '',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 12))),
                                    DataCell(Text(history['year'],
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 12))),
                                    DataCell(
                                      Row(
                                        children: [
                                          // Generated code for this Button Widget...
                                          FlutterFlowIconButton(
                                            borderColor: Colors
                                                .transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 50,
                                            icon: Icon(
                                              Icons.delete,
                                              color: Color(
                                                  0xFFEE0000),
                                              size: 25,
                                            ),
                                            onPressed: () async {
                                              bool pressed =
                                              await alert(
                                                  context,
                                                  'Do you want Delete');

                                              if (pressed) {
                                                edu.removeAt(
                                                    index);

                                                FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                    'candidates')
                                                    .doc(
                                                    widget.id)
                                                    .update({
                                                  'educationalDetails':
                                                  edu,
                                                });

                                                showUploadMessage(
                                                    context,
                                                    'Details Deleted...');
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    // DataCell(Text(fileInfo.size)),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ):

               //FEE
                selectedIndex==1?
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [

//head
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 20),
                            child:
                            Text('Fee Details',style: FlutterFlowTheme
                                .bodyText2
                                .override(fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize:17),)
                        ),
                        SizedBox(width: 30,),
//DueDate && Discound
//
//                         Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//
//                         Container(
//                           width: MediaQuery.of(context).size.width*0.3,
//                           child: Row(
//                             children: [
//                               Padding(
//                                   padding: EdgeInsetsDirectional.all(8),
//                                   child: InkWell(
//                                     onTap: (){
//                                       showDatePicker(
//                                           context: context,
//                                           initialDate: selectedDate,
//                                           firstDate: DateTime(1901, 1),
//                                           lastDate: DateTime(2100,1)).then((value){
//
//                                         setState(() {
//                                           DateFormat("yyyy-MM-dd").format(value);
//
//                                           dueDate = Timestamp.fromDate(DateTime(value.year,value.month
//                                               ,value.day,0,0,0));
//
//                                           selectedDate=value.add(Duration(hours: 23,minutes: 59,seconds: 59));
//                                         });
//                                       });
//
//                                     },
//                                     child: Center(
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width*0.15,
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                           BorderRadius.circular(8),
//                                           border: Border.all(
//                                             color: Color(0xFFE6E6E6),
//                                           ),
//                                         ),
//                                         child:dueDate==null? Center(
//                                           child: Text('choose Due Date',style: TextStyle(fontSize: 18,color: Colors.blue),),
//                                         )
//                                             :Center(
//                                           child: Text(dueDate.toDate().toString().substring(0,10),),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                               ),
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                                 child: FFButtonWidget(
//                                   onPressed: () {
//
//                                     if(dueDate!=null){
//
//                                       FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
//                                         'dueDate':dueDate,
//                                       });
//
//                                     }else{
//                                       showUploadMessage(context, 'Please select Due date');
//
//                                     }
//
//
//                                   },
//                                   text: 'Update',
//                                   options: FFButtonOptions(
//                                     width: 80,
//                                     height: 40,
//                                     color: Colors.teal,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: Colors.white,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     elevation: 2,
//                                     borderSide: BorderSide(
//                                       color: Colors.transparent,
//                                       width: 1,
//                                     ),
//                                     borderRadius: 50,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         discountAmount==null||discountAmount==0?
//                         Container(
//                           width: MediaQuery.of(context).size.width*0.5,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 300,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                   BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color: Color(0xFFE6E6E6),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.fromLTRB(
//                                       16, 0, 0, 0),
//                                   child: TextFormField(
//                                     controller: discount,
//                                     obscureText: false,
//                                     decoration: InputDecoration(
//                                       labelText: 'Scholarship',
//                                       labelStyle: FlutterFlowTheme
//                                           .bodyText2
//                                           .override(
//                                           fontFamily: 'Montserrat',
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12
//
//                                       ),
//                                       hintText: 'Please Enter Scholarship',
//                                       hintStyle: FlutterFlowTheme
//                                           .bodyText2
//                                           .override(
//                                           fontFamily: 'Montserrat',
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12
//
//                                       ),
//                                       enabledBorder:
//                                       UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                         borderRadius:
//                                         const BorderRadius.only(
//                                           topLeft:
//                                           Radius.circular(4.0),
//                                           topRight:
//                                           Radius.circular(4.0),
//                                         ),
//                                       ),
//                                       focusedBorder:
//                                       UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                         borderRadius:
//                                         const BorderRadius.only(
//                                           topLeft:
//                                           Radius.circular(4.0),
//                                           topRight:
//                                           Radius.circular(4.0),
//                                         ),
//                                       ),
//                                     ),
//                                     style: FlutterFlowTheme.bodyText2
//                                         .override(
//                                         fontFamily: 'Montserrat',
//                                         color: Color(0xFF8B97A2),
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12
//
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
//                                 child: FFButtonWidget(
//                                   onPressed: () {
//
//                                     if(discount.text!=''){
//                                       FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
//                                         'discount':double.tryParse(discount.text),
//                                       });
//                                     }else{
//                                       showUploadMessage(context, 'please enter scholarship Amount');
//                                     }
//
//                                     setState(() {
//
//                                     });
//
//                                   },
//                                   text: 'Add',
//                                   options: FFButtonOptions(
//                                     width: 80,
//                                     height: 40,
//                                     color: Colors.teal,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: Colors.white,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     elevation: 2,
//                                     borderSide: BorderSide(
//                                       color: Colors.transparent,
//                                       width: 1,
//                                     ),
//                                     borderRadius: 50,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                             :Container(),
//
//                       ],),
//                         SizedBox(height: 20,),

  //add fee
  //                       Container(
  //                         width: MediaQuery.of(context).size.width*0.7,
  //                           child:Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               children:[
  //
  //                                 Padding(
  //                                     padding: EdgeInsetsDirectional.all(8),
  //                                     child: InkWell(
  //                                       onTap: (){
  //                                         showDatePicker(
  //                                             context: context,
  //                                             initialDate: selectedDate,
  //                                             firstDate: DateTime(1901, 1),
  //                                             lastDate: DateTime(2100,1)).then((value){
  //
  //                                           setState(() {
  //                                             DateFormat("yyyy-MM-dd").format(value);
  //
  //                                             feePaidDate = Timestamp.fromDate(DateTime(value.year,value.month
  //                                                 ,value.day,0,0,0));
  //
  //                                             selectedDate=value.add(Duration(hours: 23,minutes: 59,seconds: 59));
  //                                           });
  //                                         });
  //
  //                                       },
  //                                       child: Center(
  //                                         child: Container(
  //                                           width: MediaQuery.of(context).size.width*0.15,
  //                                           height: 60,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.white,
  //                                             borderRadius:
  //                                             BorderRadius.circular(8),
  //                                             border: Border.all(
  //                                               color: Color(0xFFE6E6E6),
  //                                             ),
  //                                           ),
  //                                           child:feePaidDate==null? Center(
  //                                             child: Text('choose Date',style: TextStyle(fontSize: 18,color: Colors.blue),),
  //                                           )
  //                                               :Center(
  //                                             child: Text(feePaidDate.toDate().toString().substring(0,10),),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     )
  //                                 ),
  //                                 Container(
  //                                   width: MediaQuery.of(context).size.width*0.2,
  //                                   height: 60,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.white,
  //                                     borderRadius:
  //                                     BorderRadius.circular(8),
  //                                     border: Border.all(
  //                                       color: Color(0xFFE6E6E6),
  //                                     ),
  //                                   ),
  //                                   child: Padding(
  //                                     padding: EdgeInsets.fromLTRB(
  //                                         16, 0, 0, 0),
  //                                     child: TextFormField(
  //                                       controller: feepaid,
  //                                       obscureText: false,
  //                                       decoration: InputDecoration(
  //                                         labelText: 'Fees',
  //                                         labelStyle: FlutterFlowTheme
  //                                             .bodyText2
  //                                             .override(
  //                                             fontFamily: 'Montserrat',
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.w500,
  //                                             fontSize: 12
  //
  //                                         ),
  //                                         hintText: 'Please Enter Fees',
  //                                         hintStyle: FlutterFlowTheme
  //                                             .bodyText2
  //                                             .override(
  //                                             fontFamily: 'Montserrat',
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.w500,
  //                                             fontSize: 12
  //
  //                                         ),
  //                                         enabledBorder:
  //                                         UnderlineInputBorder(
  //                                           borderSide: BorderSide(
  //                                             color: Colors.transparent,
  //                                             width: 1,
  //                                           ),
  //                                           borderRadius:
  //                                           const BorderRadius.only(
  //                                             topLeft:
  //                                             Radius.circular(4.0),
  //                                             topRight:
  //                                             Radius.circular(4.0),
  //                                           ),
  //                                         ),
  //                                         focusedBorder:
  //                                         UnderlineInputBorder(
  //                                           borderSide: BorderSide(
  //                                             color: Colors.transparent,
  //                                             width: 1,
  //                                           ),
  //                                           borderRadius:
  //                                           const BorderRadius.only(
  //                                             topLeft:
  //                                             Radius.circular(4.0),
  //                                             topRight:
  //                                             Radius.circular(4.0),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       style: FlutterFlowTheme.bodyText2
  //                                           .override(
  //                                           fontFamily: 'Montserrat',
  //                                           color: Color(0xFF8B97A2),
  //                                           fontWeight: FontWeight.w500,
  //                                           fontSize: 12
  //
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Text('Bank'),
  //                                 Radio(
  //                                   activeColor: Colors.yellow,
  //                                   fillColor: MaterialStateProperty.all(Colors.black),
  //                                   overlayColor: MaterialStateProperty.all(Colors.grey[200]),
  //                                   focusColor: Colors.green,
  //                                   value: bank,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       value=true;
  //                                       bank=value;
  //                                       cash=false;
  //                                       radioval='Bank';
  //                                       print(radioval);
  //                                       radioSelected1=value;
  //                                     });
  //                                   },
  //
  //                                   groupValue: radioSelected1,
  //                                 ),
  //                                 Text('Cash'),
  //                                 Radio(
  //                                   activeColor: Colors.yellow,
  //                                   fillColor: MaterialStateProperty.all(Colors.black),
  //                                   overlayColor: MaterialStateProperty.all(Colors.grey[200]),
  //                                   focusColor: Colors.green,
  //                                   value: cash,
  //                                   onChanged: (value) {
  //                                     value=true;
  //
  //                                     setState(() {
  //                                       radioval='Cash';
  //                                       print(radioval);
  //                                       cash = value;
  //                                       bank=false;
  //                                       radioSelected1=value;
  //                                     });
  //                                   },
  //
  //                                   groupValue: radioSelected1,
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
  //                                   child: FFButtonWidget(
  //                                     onPressed: () async {
  //
  //                                       if(feepaid.text!=''&&radioval!=''){
  //                                         List feePaid=[];
  //
  //                                         DocumentSnapshot settings=
  //                                         await FirebaseFirestore.instance.collection('settings')
  //                                             .doc(currentbranchId)
  //                                             .get();
  //
  //                                         int reptNo=settings['receiptNo'];
  //
  //                                         settings.reference.update({
  //                                           'receiptNo':reptNo+1,
  //                                         });
  //
  //                                         feePaid.add({
  //                                           'feepaid':int.tryParse(feepaid.text),
  //                                           'datePaid':feePaidDate!=null?feePaidDate:DateTime.now(),
  //                                           'paymentMethod':radioval,
  //                                           'collectedBy':currentUserUid,
  //                                           'reptNo':'R'+currentbranchShortName+reptNo.toString(),
  //                                         });
  //
  //                                         settings.reference.update({
  //                                           'receiptNo':reptNo+1,
  //                                         });
  //
  //                                         print(feePaid.toString());
  //                                         FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
  //                                           'feeDetails':FieldValue.arrayUnion(feePaid),
  //                                         });
  //
  //                                         loaded=false;
  //
  //
  //                                         setState(() {
  //                                           totalFee+=double.tryParse(feepaid.text);
  //                                         });
  //
  //                                         showUploadMessage(context, 'Fee details added successfully');
  //
  //                                         feepaid.text='';
  //                                         feePaidDate==null;
  //
  //                                         setState(() {
  //
  //                                         });
  //
  //                                       }else{
  //                                         // examDate==null? showUploadMessage(context, 'Please select date'):
  //                                         feepaid.text==''? showUploadMessage(context, 'Please Enter Fee Amount')
  //                                         :showUploadMessage(context, 'Please Choose The Payment Method');
  //
  //                                       }
  //
  //
  //                                     },
  //                                     text: 'Add',
  //                                     options: FFButtonOptions(
  //                                       width: 80,
  //                                       height: 40,
  //                                       color: Colors.teal,
  //                                       textStyle: FlutterFlowTheme.subtitle2.override(
  //                                         fontFamily: 'Lexend Deca',
  //                                         color: Colors.white,
  //                                         fontSize: 13,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                       elevation: 2,
  //                                       borderSide: BorderSide(
  //                                         color: Colors.transparent,
  //                                         width: 1,
  //                                       ),
  //                                       borderRadius: 50,
  //                                     ),
  //                                   ),
  //                                 )
  //                               ]
  //                           )
  //                       ),
  //                       SizedBox(width: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                child: Text('University',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                child: Text(': ${UniversityIdToName[student['university']]}',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                child: Text('Course',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),)),
                            Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                child: Text(': ${CourseIdToName[student['course']]}',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                child: Text('Batch',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),)),
                            Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                child: Text(': ${ClassIdToName[student['classId']]}'??'',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                child: Text('DueDate',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),)),
                            Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                child: Text(': ${dateTimeFormat('d-MMM-y', duedate)}',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(width: 30,),

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: feeList.length,
                          itemBuilder: (buildContext,int index){
                            List tuitionFee=feeList[index]['tuitionFee'];

                            double tu=0;
                            double ad=0.00;
                            double un=0.00;
                            double cn=0.00;

                            print(tuitionFee);
                              for(var tuition in tuitionFee){
                                tu+=tuition['amount'];
                              }
                               ad=feeList[index]['admissionFee'];
                               un=feeList[index]['universityFee'];
                               cn=feeList[index]['convocationFee'];
                               yearTotalFee=feeList[index]['currentYearTotalFee'];

                            paidFee=double.tryParse(tu.toString());
                            print(paidFee);

                            return Padding(
                              padding: const EdgeInsets.only(top: 10,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    // height: MediaQuery.of(context).size.height*0.25,
                                    width: MediaQuery.of(context).size.width*0.73,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 30,right: 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                                          child: Text(index==0?'First Year':index==1?'Second Year':'Final Year',
                                            style: FlutterFlowTheme.title1.override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text('Total Fee',
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),)),
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text(feeList[index]['currentYearTotalFee'].toString(),
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.1,
                                                child: Text('Admission Fee',
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),)),
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text(feeList[index]['admissionFee'].toString(),
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text('University Fee',
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text(feeList[index]['universityFee'].toString(),
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text('Convocation Fee',
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text(feeList[index]['convocationFee'].toString(),
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text('Scholarship',
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.1,
                                                child: Text(feeList[index]['scholarship'].toString(),
                                                  style: FlutterFlowTheme.title1.override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ))
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
                                                DataColumn(
                                                  label: Text(
                                                    "Transaction Id",
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
                                                      DataCell(SelectableText(
                                                        tuitionFee[index]['paymentId']??' ',
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
                                        Padding(
                                            padding: EdgeInsets.only(top: 20,bottom: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsetsDirectional.all(8),
                                                  child: InkWell(
                                                    onTap: (){
                                                      showDatePicker(
                                                          context: context,
                                                          initialDate: selectedDate,
                                                          firstDate: DateTime(1901, 1),
                                                          lastDate: DateTime(2100,1)).then((value){
                                                            setState(() {
                                                              DateFormat("yyyy-MM-dd").format(value);
                                                              feePaidDate = Timestamp.fromDate(DateTime(value.year,value.month
                                                                  ,value.day,0,0,0));
                                                              selectedDate=value.add(Duration(hours: 23,minutes: 59,seconds: 59));
                                                            });
                                                          });
                                                      },
                                                    child: Center(
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.15,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(8),
                                                          border: Border.all(
                                                            color: Color(0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child:feePaidDate==null? Center(
                                                          child: Text('choose Date',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                                        )
                                                            :Center(
                                                          child: Text(feePaidDate.toDate().toString().substring(0,10),),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              // due==0?add
                                              (yearTotalFee-paidFee).toString()!='0'?
                                              Row(
                                                children: [
                                                  Container(
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
                                                        controller: pay,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelText: 'Amount',
                                                          labelStyle: FlutterFlowTheme
                                                              .bodyText2
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          hintText:
                                                          'Enter the Amount',
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
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text('Bank'),
                                                        SizedBox(width: 15,),
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
                                                        SizedBox(width: 30,),
                                                        Text('Cash'),
                                                        SizedBox(width: 15,),
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
                                                  ),
                                                  InkWell(
                                                    onTap: () async {

                                                      if(pay.text!=''&&radioval!=''&&feePaidDate!=null){
                                                        bool pressed=await alert(context, 'pay amount');
                                                        if(pressed){

                                                          List currentTotal= student['feeDetails'];
                                                          List currentYrTu= currentTotal[index]['tuitionFee'];

                                                          currentYrTu.add({
                                                            'date': feePaidDate,
                                                            'amount': double.tryParse(pay.text),
                                                            'modeOfPayment':radioval,
                                                            'userId':currentUserUid,
                                                            'paymentId':''
                                                          });
                                                          currentTotal[index]['tuitionFee']=currentYrTu;
                                                          print(currentTotal[index]['tuitionFee']);
                                                          print(currentYrTu);

                                                          student.reference.update({
                                                            'feeDetails':currentTotal,
                                                            'dueDate':DateTime(duedate.year, duedate.month+3, duedate.day)
                                                          });

                                                          String courseName=CourseIdToName[student['course']];
                                                          String intakeName=InTakeIdToName[student['inTake']];
                                                          List email=[];
                                                          email.add(student['email']);

                                                          paymentSuccessEmail(radioval,courseName,intakeName,email,pay.text,student['name']);

                                                          showUploadMessage(context,'Amount paid successfully');
                                                          pay.text='';
                                                        }
                                                      }
                                                      feePaidDate==null? showUploadMessage(context,'Please select Date'):
                                                      pay.text==''? showUploadMessage(context,'Please enter the amount'):
                                                      showUploadMessage(context, 'Please select payment method');

                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.teal
                                                      ),
                                                      child: Center(
                                                          child: Text('Add'
                                                            ,style: TextStyle(fontSize: 15,color: Colors.white),)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                              :Container(),


                                            ],
                                          ),

                                        ),
                                        //due & paid amount
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.13,
                                                    child: Text('Paid Amount',
                                                      style: FlutterFlowTheme.title1.override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                      ),)),
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.07,
                                                    child: Center(
                                                      child: Text(': ${paidFee.toStringAsFixed(2)}',
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
                                                    width: MediaQuery.of(context).size.width*0.13,
                                                    child: Text('Due Amount(-Scholarship)',
                                                      style: FlutterFlowTheme.title1.override(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                      ),)),
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.07,
                                                    child: Center(
                                                      child: Text(': ${(yearTotalFee-paidFee-feeList[index]['scholarship']).toStringAsFixed(2)}',
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
                                          ],
                                        ),

                                        //UPGRADE BUTTON
                                        student['currentYear']!=student['courseDuration']&&index+1>=student['currentYear']
                                            &&yearTotalFee-paidFee==0?
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  print(paidFee);
                                                  print(yearTotalFee);
                                                  if(paidFee==yearTotalFee){
                                                    print('aaa');
                                                    bool proceed = await alert(context, 'You want to upgrade This student?');
                                                    if(proceed){
                                                      return showDialog<void>(
                                                        context: context,
                                                        barrierDismissible: true, // user must tap button!
                                                        builder: (BuildContext context) {
                                                          return CreateNewPopup(
                                                            course:student['course'],
                                                            univerity:student['university'],
                                                            studentId:widget.id,
                                                            yearIndex:student['currentYear']
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }
                                                  showUploadMessage(context, 'Please Complete Fee');
                                                },
                                                text: 'Upgarde',
                                                options: FFButtonOptions(
                                                  width: MediaQuery.of(context).size.width*0.1,
                                                  height: 40,
                                                  color: Color(0xFF4B39EF),
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
                                            ],
                                          ),
                                        )
                                            :Container(),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  int finalYearIndex=student['courseDuration'];
                                  print(finalYearIndex);
                                  print(feeList[finalYearIndex-1]);

                                  if(feeList[finalYearIndex-1]!=null){

                                    double finalYearAd=feeList[finalYearIndex-1]['admissionFee'];
                                    double finalYearUd=feeList[finalYearIndex-1]['universityFee'];
                                    double finalYearCv=feeList[finalYearIndex-1]['convocationFee'];
                                    double finalYearSh=feeList[finalYearIndex-1]['scholarship'];

                                    double finalYearTu=0.00;

                                    for(var tuition in feeList[finalYearIndex-1]['tuitionFee']){
                                      finalYearTu+=tuition['amount'];
                                    }
                                    print(finalYearAd.toString()+'    ad FEE');
                                    print(finalYearUd.toString()+'    ud FEE');
                                    print(finalYearCv.toString()+'    cv FEE');
                                    print(finalYearTu.toString()+'    tu FEE');

                                    double sum=finalYearAd+finalYearUd+finalYearCv+finalYearSh+finalYearTu;
                                    print(sum.toString()+'       SUM');
                                    if(sum==feeList[finalYearIndex-1]['currentYearTotalFee']){
                                      bool proceed = await alert(context, 'You want to upgrade This student?');
                                      if(proceed){
                                        FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
                                          'status': 1,
                                          'courseCompletedDate':DateTime.now(),
                                        });
                                        showUploadMessage(context, 'This Student converted to course completed list');
                                        Navigator.pop(context);
                                        print(true);
                                      }
                                     }
                                    setState(() {

                                    });

                                  }else{
                                    showUploadMessage(context, 'Cannot convert to course completed list');
                                  }
                                },
                                text: 'Completed',
                                options: FFButtonOptions(
                                  width: MediaQuery.of(context).size.width*0.1,
                                  height: 40,
                                  color: Colors.green,
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
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {

                                  if(student['status']==0){
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Register as Drop out ?'),
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

                                                  FirebaseFirestore.instance
                                                      .collection('candidates')
                                                      .doc(widget.id)
                                                      .update({
                                                    'status': 2,
                                                    'dropOutReason':reason.text,
                                                    'dropOutDate':DateTime.now(),
                                                  });

                                                  Navigator.pop(context);

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
                                  }
                                  },
                                text: 'Drop Out',
                                options: FFButtonOptions(
                                  width: MediaQuery.of(context).size.width*0.1,
                                  height: 40,
                                  color: Colors.red,
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ):

               //CLASS
                selectedIndex==2?
                Column(
                    children: [

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40,20),
                        child: SizedBox(
                           width: MediaQuery.of(context).size.width*0.9,
                          child:
                          // StreamBuilder<QuerySnapshot>(
                          //   stream: FirebaseFirestore.instance.collection('zoomClass')
                          //   .orderBy('scheduled', descending: true)
                          //       .where('batch',isEqualTo: student['classId'])
                          //       .snapshots(),
                          //   builder: (context, snapshot) {
                          //     if(!snapshot.hasData){
                          //       return Center(child: CircularProgressIndicator(),);
                          //     }
                          //     var classData=snapshot.data.docs;
                          //     return classData.length==0?Center(
                          //       child: CircularProgressIndicator(),
                          //     ):
                              DataTable(
                                horizontalMargin: 12,
                                columns: [
                                  DataColumn(label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                  DataColumn(label: Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                  DataColumn(label: Text("Tutor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                  DataColumn(label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                  DataColumn(label: Text("Subject",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                  DataColumn(label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11)),),
                                ],
                                rows: List.generate(
                                  classess.length,
                                      (index) {
                                    var list=classess[index];

                                    return DataRow(
                                      color: index.isOdd?
                                      MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                          :MaterialStateProperty.all(Colors.blueGrey.shade50),

                                      cells: [
                                        DataCell(Text(list['name'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                        DataCell(Text(list['description'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                        DataCell(Text(tutorIdToName[list['tutor']]??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                        DataCell(Text(list['scheduled'].toDate().toString().substring(0,16),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                        DataCell(Text(list['subject'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),
                                        DataCell(Text(list['status']==0?'Scheduled':'Finished',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11))),

                                      ],
                                    );
                                  },
                                ),
                              )
                          //   }
                          // ),
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

                          classess.length<limit||classess.length==0?
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
                      )
                    ],
                ):
                    
                //DOCUMENTS
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 30,right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
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
                            DataColumn(
                              label:  Text(
                                " ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),

                          ],
                          rows: List.generate(
                            uploadDocument.length,
                                (index) {
                              var docName = uploadDocument[index];
                              print(studentDocument.keys.toList());


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
                                          selectFileToMessage(docName.toUpperCase());
                                          setState(() {

                                          });
                                        }
                                      },
                                      text: studentDocument.keys.toList().contains(docName.toString().toUpperCase())?'Edit':'Upload'
                                      ,options: FFButtonOptions(
                                      width: 100,
                                      height: 40,
                                      color: studentDocument.keys.toList().contains(docName.toString().toUpperCase())? Color(0xFF4B39EF):Colors.teal,
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
                                  studentDocument.keys.toList().contains(docName.toString().toUpperCase())?
                                  DataCell( Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                    child: FFButtonWidget(
                                      onPressed: ()  async {
                                        launchURL(studentDocument[docName.toString().toUpperCase()]);
                                      },
                                      icon: Icon(Icons.download),
                                      text: 'Download'
                                      ,options: FFButtonOptions(
                                      width: 150,
                                      height: 40,
                                      color: Colors.grey,
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
                                  ))
                                  :DataCell(Container()),

                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              student['verified']==0||student['verified']==2?
                              InkWell(
                                onTap:() async {

                                  await  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.0)
                                    ),
                                    title: Text('Reject Student ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: (){
                                          Navigator.of(context, rootNavigator: true).pop(false);
                                        },
                                        child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            )
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: (){
                                          student.reference
                                              .update({
                                            'verified':1,
                                          });
                                          setState(() {

                                          });
                                          Navigator.of(context, rootNavigator: true).pop(false);
                                        },
                                        child: Text(
                                            'Verify',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue
                                            )
                                        ),
                                      )
                                    ],
                                  )
                                  );

                                  },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue
                                  ),
                                  child: Center(
                                      child: Text('Verify Student'
                                        ,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)
                                  ),
                                ),
                              )
                                  :Container(),

                              SizedBox(width: 20,),

                              student['verified']==0?
                              InkWell(
                                onTap: () async {

                                  String course=CourseIdToName[student['course']];
                                  String intake=InTakeIdToName[student['inTake']];
                                  String name='${student['name']} ${student['lastName']}';
                                  List emailList=[];
                                  emailList.add(student['email']);


                                  await  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.0)
                                    ),
                                    title: Text('Reject Student ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: (){
                                          Navigator.of(context, rootNavigator: true).pop(false);
                                        },
                                        child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            )
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: (){
                                          student.reference
                                              .update({
                                            'verified':2,
                                          });
                                          setState(() {

                                          });
                                          reject(course,emailList,name,intake);

                                          Navigator.of(context, rootNavigator: true).pop(false);
                                        },
                                        child: Text(
                                            'Reject',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue
                                            )
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: (){

                                          student.reference
                                              .update({
                                            'verified':2,
                                          });

                                          String paymentId='';
                                          for(var data in student['feeDetails']){
                                            for(var tu in data['tuitionFee']){
                                              print(data['tuitionFee'][0]['paymentId']);
                                              paymentId=data['tuitionFee'][0]['paymentId'];
                                            }
                                          }

                                          rejectAndRefund(course,emailList,name,intake);
                                          generate_ODID(paymentId);

                                          Navigator.of(context, rootNavigator: true).pop(false);

                                          setState(() {

                                          });

                                          Navigator.of(context, rootNavigator: true).pop(false);
                                        },
                                        child: Text(
                                            'Reject and Refund',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue
                                            )
                                        ),
                                      )
                                    ],
                                  )
                                  );

                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red
                                  ),
                                  child: Center(
                                      child: Text('Reject Student'
                                        ,style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),)
                                  ),
                                ),
                              )
                                  :Container(),
                            ],
                        ),
                      )

                    ],
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}
