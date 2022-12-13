import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smile_erp/Login/login.dart';
import 'package:smile_erp/app/app_widget.dart';
import 'package:smile_erp/backend/schema/index.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:universal_html/html.dart';

import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../pages/home_page/home.dart';

class AddTutor extends StatefulWidget {
  const AddTutor({Key key}) : super(key: key);

  @override
  State<AddTutor> createState() => _AddTutorState();
}

class _AddTutorState extends State<AddTutor> {
  TextEditingController name;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController department;
  TextEditingController userName;
  TextEditingController password;
  String uploadedFileUrl='';

  TextEditingController ename;
  TextEditingController eemail;
  TextEditingController ephone;
  TextEditingController edepartment;
  TextEditingController euserName;
  TextEditingController epassword;
  String euploadedFileUrl='';
  String docId;

  bool edit=false;

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=10;
  List tutorList=[];
  getTutor(){
    FirebaseFirestore.instance
        .collection('tutor')
        .limit(limit)
        .snapshots()
        .listen((event) {
      tutorList=[];
      for(var students in event.docs){
        tutorList.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(tutorList.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getTutor();
    } else {
      FirebaseFirestore.instance
          .collection('tutor')
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        tutorList = [];
        for (DocumentSnapshot orders in event.docs) {
          tutorList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});print('  next  ');
          print(tutorList.length.toString()+'                mmmmmm');
          print(lastDoc.toString()+'                jjj');
        }

      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getTutor();
    } else {
      FirebaseFirestore.instance
          .collection('tutor')
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        tutorList = [];
        for (DocumentSnapshot orders in event.docs) {
          tutorList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(tutorList.length.toString()+'                mmmmmm');
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
    name=TextEditingController();
    email=TextEditingController();
    phone=TextEditingController();
    department=TextEditingController();
    userName=TextEditingController();
    password=TextEditingController();

    ename=TextEditingController();
    eemail=TextEditingController();
    ephone=TextEditingController();
    edepartment=TextEditingController();
    euserName=TextEditingController();
    epassword=TextEditingController();
    getTutor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'Add Tutor',
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

              edit==false?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.45,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Addd Tutor',
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
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
                                  final selectedMedia = await selectMedia(
                                    mediaSource: MediaSource.photoGallery,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath, context)) {
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
                                    final uploadSnap = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(0, 10))
                                        .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(10, 17))
                                        .putData(selectedMedia.bytes, metadata);
                                    final downloadUrl =
                                    await uploadSnap.ref.getDownloadURL();
                                    // final downloadUrl = await uploadData(
                                    //     selectedMedia.storagePath, selectedMedia.bytes);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (downloadUrl != null) {
                                      setState(
                                              () => uploadedFileUrl = downloadUrl);
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                      return;
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
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
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
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
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Email',
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
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                width: 350,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.phone,
                                    validator: (email) {
                                      if (email.isEmpty) {
                                        return "Enter your phone number";
                                      } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(email)) {
                                        return "phone number is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: phone,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12

                                      ),
                                      hintText: 'Please Enter Mobile No',
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
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 400,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child:
                                  Center(
                                    child: CustomDropdown.search(
                                      hintText: 'Select department',hintStyle: TextStyle(color:Colors.black),
                                      items: dept,
                                      controller: department,
                                      // excludeSelected: false,
                                      onChanged: (text){
                                        setState(() {

                                        });

                                      },
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
                                    controller: userName,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Username',
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
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value.length != 6) {
                                        return "password length must be six characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: password,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Password',
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

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                DocumentSnapshot doc= await FirebaseFirestore.instance
                                    .collection('settings')
                                .doc(currentbranchId)
                                .get();
                                doc.reference.update({
                                  'tutorNo':FieldValue.increment(1),
                                  'userId':FieldValue.increment(1),
                                });

                                // int tutorNo=doc.get('tutorNo');
                                int userNo=doc.get('userId');
                                userNo++;

                                if(name.text!=''&&email.text!=''&&phone.text!=''&&department.text!=''
                                    &&userName.text!=''&&password.text!=''&&uploadedFileUrl!=''){
                                  
                                  FirebaseFirestore.instance
                                      .collection('tutor')
                                      .doc('U$userNo')
                                      .set({
                                    'name':name.text,
                                    'email':email.text,
                                    'phone':phone.text,
                                    'department':department.text,
                                    'userName':userName.text,
                                    'password':password.text,
                                    'tutorId':'U$userNo',
                                    'available':true,
                                    'image':uploadedFileUrl,
                                  });
                                  
                                  FirebaseFirestore.instance
                                      .collection('admin_users')
                                      .doc('U$userNo')
                                  .set({
                                    'department':department.text,
                                    'display_name': name.text,
                                    'email': email.text,
                                    'password': password.text,
                                    'mobileNumber': phone.text,
                                    'role': 'tutor',
                                    'photo_url': uploadedFileUrl,
                                    'userName': userName.text,
                                    'verified': true,
                                    'uid':'U$userNo',
                                  });

                                  
                                  name.text='';
                                  email.text='';
                                  phone.text='';
                                  department.text='';
                                  userName.text='';
                                  password.text='';
                                  uploadedFileUrl='';


                                  showUploadMessage(context, 'Tutor added scuccessfully');
                                }else{
                                  name.text==''?showUploadMessage(context, 'please enter name'):
                                  email.text==''?showUploadMessage(context, 'please enter email'):
                                  phone.text==''?showUploadMessage(context, 'please enter phone'):
                                  department.text==''?showUploadMessage(context, 'please enter department'):
                                  userName.text==''?showUploadMessage(context, 'please enter username'):
                                  uploadedFileUrl==''?showUploadMessage(context, 'please upload image'):
                                      showUploadMessage(context, 'please enter password');
                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.06,
                                width: MediaQuery.of(context).size.width*0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue,
                                ),
                              child: Center(child: Text('ADD TUTOR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15
                              ),)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
                  :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.45,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Edit Tutor',
                                style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            edit==true?
                            InkWell(
                              onTap: (){
                                edit=false;
                                docId;
                                setState(() {

                                });
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                    child: Text('Clear',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),)
                                ),
                              ),
                            )
                                :Container(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
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
                                  final selectedMedia = await selectMedia(
                                    mediaSource: MediaSource.photoGallery,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath, context)) {
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
                                    final uploadSnap = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(0, 10))
                                        .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(10, 17))
                                        .putData(selectedMedia.bytes, metadata);
                                    final downloadUrl =
                                    await uploadSnap.ref.getDownloadURL();
                                    // final downloadUrl = await uploadData(
                                    //     selectedMedia.storagePath, selectedMedia.bytes);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (downloadUrl != null) {
                                      setState(
                                              () => euploadedFileUrl = downloadUrl);
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                      return;
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
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
                                    controller: ename,
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
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: eemail,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (email) {
                                      if (email.isEmpty) {
                                        return "Enter your email";
                                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                          .hasMatch(email)) {
                                        return "Email not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Email',
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
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                width: 350,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.phone,
                                    validator: (email) {
                                      if (email.isEmpty) {
                                        return "Enter your phone number";
                                      } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(email)) {
                                        return "phone number is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: ephone,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12

                                      ),
                                      hintText: 'Please Enter Mobile No',
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
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 400,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child:
                                  Center(
                                    child: CustomDropdown.search(
                                      hintText: 'Select department',hintStyle: TextStyle(color:Colors.black),
                                      items: dept,
                                      controller: edepartment,
                                      // excludeSelected: false,
                                      onChanged: (text){
                                        setState(() {

                                        });

                                      },
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
                                    controller: euserName,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Username',
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
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value.length != 6) {
                                        return "password length must be six characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: epassword,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                      hintText: 'Please Enter Password',
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

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {


                                if(ename.text!=''&&eemail.text!=''&&ephone.text!=''&&edepartment.text!=''
                                    &&euserName.text!=''&&epassword.text!=''&&euploadedFileUrl!=''){

                                  FirebaseFirestore.instance
                                      .collection('tutor')
                                      .doc('U$docId')
                                      .set({
                                    'name':ename.text,
                                    'email':eemail.text,
                                    'phone':ephone.text,
                                    'department':edepartment.text,
                                    'userName':euserName.text,
                                    'password':epassword.text,
                                    'tutorId':'U$docId',
                                    'available':true,
                                    'image':euploadedFileUrl,
                                  });

                                  FirebaseFirestore.instance
                                      .collection('admin_users')
                                      .doc('U$docId')
                                      .set({
                                    'department':edepartment.text,
                                    'display_name': ename.text,
                                    'email': eemail.text,
                                    'password': epassword.text,
                                    'mobileNumber': ephone.text,
                                    'role': 'tutor',
                                    'photo_url': euploadedFileUrl,
                                    'userName': euserName.text,
                                    'verified': true,
                                    'uid':'U$docId',
                                  });


                                  name.text='';
                                  email.text='';
                                  phone.text='';
                                  department.text='';
                                  userName.text='';
                                  password.text='';
                                  uploadedFileUrl='';


                                  showUploadMessage(context, 'Tutor details edited scuccessfully');
                                }else{
                                  name.text==''?showUploadMessage(context, 'please enter name'):
                                  email.text==''?showUploadMessage(context, 'please enter email'):
                                  phone.text==''?showUploadMessage(context, 'please enter phone'):
                                  department.text==''?showUploadMessage(context, 'please enter department'):
                                  userName.text==''?showUploadMessage(context, 'please enter username'):
                                  uploadedFileUrl==''?showUploadMessage(context, 'please upload image'):
                                  showUploadMessage(context, 'please enter password');
                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.06,
                                width: MediaQuery.of(context).size.width*0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue,
                                ),
                                child: Center(child: Text('Edit TUTOR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15
                                  ),)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 15,),
              Padding(
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
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Department",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Username",
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
                                "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            tutorList.length,
                                (index) {

                              return DataRow(
                                color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                    :MaterialStateProperty.all(Colors.blueGrey.shade50),

                                cells: [
                                  DataCell(SelectableText(
                                    tutorList[index]['name'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    tutorList[index]['email'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    tutorList[index]['phone'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    tutorList[index]['department'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    tutorList[index]['userName'],
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

                                        bool pressed = await alert(context, 'Do you want to change access?');
                                        if(pressed){
                                          FirebaseFirestore.instance
                                          .collection('')
                                          .doc(tutorList[index]['tutorId'])
                                              .update({
                                            'available': !tutorList[index]['available'],
                                          });

                                        }

                                      },
                                      text: tutorList[index]['available']==true?'Veryfied':'Blocked',
                                      options: FFButtonOptions(
                                        width: 80,
                                        height: 30,
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: tutorList[index]['available']==true?Colors.teal:Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                    ),
                                  DataCell(
                                    FFButtonWidget(
                                      onPressed: () async {
                                        if(currentUserRole=='Super Admin' || currentUserRole=='coordinator'){

                                          bool pressed = await alert(context, 'Do you want to edit details?');
                                          if(pressed){
                                            edit=true;

                                            ename.text= tutorList[index]['name'];
                                            eemail.text=tutorList[index]['email'];
                                            ephone.text= tutorList[index]['phone'];
                                            edepartment.text=tutorList[index]['department'];
                                            euserName.text=tutorList[index]['userName'];
                                            epassword.text=tutorList[index]['password'];
                                            euploadedFileUrl=tutorList[index]['image'];
                                            docId=tutorList[index]['tutorId'];


                                            setState(() {

                                            });

                                          }

                                        }else{
                                          showUploadMessage(context, 'access denied');
                                        }
                                      },
                                      text: 'Edit',
                                      options: FFButtonOptions(
                                        width: 80,
                                        height: 30,
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.teal,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                    )

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

                  tutorList.length<limit||tutorList.length==0?
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
          ),
        ),
      ),
    );
  }
}
