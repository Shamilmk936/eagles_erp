import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smile_erp/Login/login.dart';
import 'package:smile_erp/app/tabs/Branch/AddBranch.dart';
import 'package:smile_erp/app/tabs/users/user_details.dart';
import 'package:smile_erp/auth/auth_util.dart';
import 'package:smile_erp/flutter_flow/upload_media.dart';
import 'package:flutter/services.dart';
import 'package:mime_type/mime_type.dart';

import 'package:flutter/material.dart';

import '../../../auth/email_auth.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class CreateUsersWidget extends StatefulWidget {
  const CreateUsersWidget({Key key}) : super(key: key);

  @override
  _CreateUsersWidgetState createState() => _CreateUsersWidgetState();
}

class _CreateUsersWidgetState extends State<CreateUsersWidget> {
  String uploadedFileUrl = '';
  String editFileUrl = '';

  String userSelectValue;
  String editUserRole;
  String editUserId;

  TextEditingController name;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController userName;
  TextEditingController password;

  TextEditingController editName;
  TextEditingController editEmail;
  TextEditingController editPhone;
  TextEditingController editPassword;
  TextEditingController editUserName;

  bool edit=false;

  //Pagination

  var lastDoc;
  var firstDoc;
  Map <int,DocumentSnapshot> lastDocuments={};
  int pageIndex=0;
  int limit=10;
  List userList=[];
  getAdminUsers(){
    FirebaseFirestore.instance
        .collection('admin_users')
        .limit(limit)
        .snapshots()
        .listen((event) {
      userList=[];
      for(var students in event.docs){
        userList.add(students.data());
      }
      lastDoc = event.docs.last;
      lastDocuments[pageIndex] = lastDoc;
      firstDoc = event.docs.first;
      if(mounted){
        setState(() {

        });
      }
    });
    print(userList.length);
    print('mmmm');
  }
  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {

      print(lastDoc.toString()+'nnnnnnnnnnnnnnnnnn');
      getAdminUsers();
    } else {
      FirebaseFirestore.instance
          .collection('admin_users')
          .startAfterDocument(lastDoc)
          .limit(limit)
          .snapshots()
          .listen((event) {

        userList = [];
        for (DocumentSnapshot orders in event.docs) {
          userList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        if (mounted) {
          setState(() {});print('  next  ');
          print(userList.length.toString()+'                mmmmmm');
          print(lastDoc.toString()+'                jjj');
        }

      });
    }

    setState(() {});
  }
  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      getAdminUsers();
    } else {
      FirebaseFirestore.instance
          .collection('admin_users')
          .startAfterDocument(lastDocuments[pageIndex - 1])
          .limit(limit)
          .snapshots()
          .listen((event) {
        userList = [];
        for (DocumentSnapshot orders in event.docs) {
          userList.add(orders.data());
        }
        lastDoc = event.docs.last;
        lastDocuments[pageIndex] = lastDoc;
        firstDoc = event.docs.first;
        print('  prev  ');
        print(userList.length.toString()+'                mmmmmm');
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getAdminUsers();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    userName = TextEditingController();
    password = TextEditingController();

    editName = TextEditingController();
    editEmail = TextEditingController();
    editPhone = TextEditingController();
    editUserName = TextEditingController();
    editPassword = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    print(uploadedFileUrl);
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Create User',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    edit==true?
                    InkWell(
                      onTap: (){
                        edit=false;
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
              ),
              edit==false?
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Add User',
                          style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                child: TextFormField(
                                  controller: name,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Name',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 350,
                              color: Colors.white,
                              padding: EdgeInsets.only(right: 10),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: TextFormField(
                                  controller: phone,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter phone number";
                                    } else if (!RegExp(
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                        .hasMatch(value)) {
                                      return "phone number is not valid";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Phone',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Phone',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      errorBorder: errorOutlineInputBOrder,
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      focusedErrorBorder:
                                          errorOutlineInputBOrder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 8, right: 8),
                              child: TextFormField(
                                controller: email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
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
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: FlutterFlowTheme.bodyText2
                                        .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                    hintText: 'Please Enter Email',
                                    hintStyle: FlutterFlowTheme.bodyText2
                                        .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                    errorBorder: errorOutlineInputBOrder,
                                    border: outlineInputBorder,
                                    disabledBorder: outlineInputBorder,
                                    focusedErrorBorder: errorOutlineInputBOrder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: outlineInputBorder),
                                style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlutterFlowDropDown(
                                initialOption: userSelectValue ?? 'Councilor',
                                options: [
                                  'Councilor',
                                  'Reception',
                                  'Finance',
                                  'Happiness Officer',
                                  'coordinator'
                                ],
                                onChanged: (val) =>
                                    setState(() => userSelectValue = val),
                                width: double.infinity,
                                height: 50,
                                textStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF14181B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Select User',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF57636C),
                                  size: 15,
                                ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Colors.grey,
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                child: TextFormField(
                                  controller: userName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'User Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Username',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: password,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value.length != 6) {
                                        return "password length must be six characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        hintText: 'Please Enter Password',
                                        hintStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        errorBorder: errorOutlineInputBOrder,
                                        focusedErrorBorder:
                                            errorOutlineInputBOrder,
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                            child: FFButtonWidget(
                              onPressed: () async {

                                DocumentSnapshot doc= await FirebaseFirestore.instance
                                    .collection('settings').doc(currentbranchId).get();
                                
                                int uId=doc.get('userId');
                                print(uId);

                                if (name.text != '' &&
                                    email.text != '' &&
                                    password.text != '' &&
                                    phone.text != '' &&
                                    userName.text != '' &&
                                    userSelectValue != '' &&
                                    currentUserRole=='coordinator' &&
                                    currentUserRole=='Super Admin' ) {

                                  FirebaseFirestore.instance
                                      .collection('admin_users')
                                  .doc('U$uId')
                                      .set({
                                    'display_name': name.text,
                                    'email': email.text,
                                    'password': password.text,
                                    'mobileNumber': phone.text,
                                    'role': userSelectValue,
                                    'photo_url': uploadedFileUrl,
                                    'userName': userName.text,
                                    'verified': true,
                                    'uid':'U$uId',
                                  }).then((value) {

                                    doc.reference.update({
                                      'userId':FieldValue.increment(1),
                                    });

                                    FirebaseFirestore.instance
                                        .collection('branch')
                                        .doc(currentbranchId)
                                        .update({
                                      'staff':
                                          FieldValue.arrayUnion([email.text]),
                                    });
                                  });
                                  showUploadMessage(context, 'new User added successfully');
                                  name.text='';
                                  userName.text='';
                                  email.text='';
                                  password.text='';
                                  phone.text='';

                                } else {
                                  name.text == ''
                                      ? showUploadMessage(
                                          context, 'Please enter user name')
                                      : userName.text == ''
                                          ? showUploadMessage(context,
                                              'Please enter user username')
                                          : email.text == ''
                                              ? showUploadMessage(context,
                                                  'Please enter  emailId')
                                              : password.text == ''
                                                  ? showUploadMessage(context,
                                                      'Please enter  password')
                                                  : phone.text == ''
                                                      ? showUploadMessage(
                                                          context,
                                                          'Please enter  mobile number')
                                                      : showUploadMessage(
                                                          context,
                                                          'Please choose role');
                                }

                              },
                              text: 'Create',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: Colors.teal,
                                textStyle: FlutterFlowTheme.subtitle2.override(
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
                        ],
                      ),
                    ],
                  ),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Edit User',
                          style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
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
                                            () => editFileUrl = downloadUrl);
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                child: TextFormField(
                                  controller: editName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      hintText: 'Please Enter Name',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 350,
                              color: Colors.white,
                              padding: EdgeInsets.only(right: 10),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: TextFormField(
                                  controller: editPhone,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter phone number";
                                    } else if (!RegExp(
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                        .hasMatch(value)) {
                                      return "phone number is not valid";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Phone',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      hintText: 'Please Enter Phone',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      errorBorder: errorOutlineInputBOrder,
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      focusedErrorBorder:
                                      errorOutlineInputBOrder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 8, right: 8),
                              child: TextFormField(
                                controller: editEmail,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
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
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: FlutterFlowTheme.bodyText2
                                        .override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    hintText: 'Please Enter Email',
                                    hintStyle: FlutterFlowTheme.bodyText2
                                        .override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    errorBorder: errorOutlineInputBOrder,
                                    border: outlineInputBorder,
                                    disabledBorder: outlineInputBorder,
                                    focusedErrorBorder: errorOutlineInputBOrder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: outlineInputBorder),
                                style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlutterFlowDropDown(
                                initialOption: editUserRole ?? 'Councilor',
                                options: [
                                  'Councilor',
                                  'Reception',
                                  'Finance',
                                  'Happiness Officer',
                                  'coordinator'
                                ],
                                onChanged: (val) =>
                                    setState(() => editUserRole = val),
                                width: double.infinity,
                                height: 50,
                                textStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF14181B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Select User',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF57636C),
                                  size: 15,
                                ),
                                fillColor: Colors.white,
                                elevation: 2,
                                borderColor: Colors.grey,
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                child: TextFormField(
                                  controller: editUserName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'User Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      hintText: 'Please Enter Username',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: editPassword,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value.length != 6) {
                                        return "password length must be six characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                        hintText: 'Please Enter Password',
                                        hintStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                        errorBorder: errorOutlineInputBOrder,
                                        focusedErrorBorder:
                                        errorOutlineInputBOrder,
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                            child: FFButtonWidget(
                              onPressed: () async {


                                if (editName.text != '' &&
                                    editEmail.text != '' &&
                                    editPassword.text != '' &&
                                    editPhone.text != '' &&
                                    editUserName.text != '' &&
                                    editUserRole != '') {
                                  FirebaseFirestore.instance
                                      .collection('admin_users')
                                      .doc(editUserId)
                                      .update({
                                    'display_name': editName.text,
                                    'email': editEmail.text,
                                    'password': editPassword.text,
                                    'mobileNumber': editPhone.text,
                                    'role': editUserRole,
                                    'photo_url': editFileUrl,
                                    'userName': editUserName.text,
                                    'verified': true,
                                    'uid':editUserId,
                                  }).then((value) {

                                    FirebaseFirestore.instance
                                        .collection('branch')
                                        .doc(currentbranchId)
                                        .update({
                                      'staff':
                                      FieldValue.arrayUnion([email.text]),
                                    });
                                  });
                                  showUploadMessage(context, 'new User added successfully');
                                  editName.text='';
                                  editEmail.text='';
                                  editPassword.text='';
                                  editPhone.text='';
                                  editUserName.text='';
                                  editUserRole='';

                                } else {
                                  name.text == ''
                                      ? showUploadMessage(
                                      context, 'Please enter user name')
                                      : userName.text == ''
                                      ? showUploadMessage(context,
                                      'Please enter user username')
                                      : email.text == ''
                                      ? showUploadMessage(context,
                                      'Please enter  emailId')
                                      : password.text == ''
                                      ? showUploadMessage(context,
                                      'Please enter  password')
                                      : phone.text == ''
                                      ? showUploadMessage(
                                      context,
                                      'Please enter  mobile number')
                                      : showUploadMessage(
                                      context,
                                      'Please choose role');
                                }

                              },
                              text: 'Update',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: Colors.teal,
                                textStyle: FlutterFlowTheme.subtitle2.override(
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 30, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Users List',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
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
                                "Role",
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
                            // DataColumn(
                            //   label: Text(
                            //     "Details",
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold, fontSize: 11),
                            //   ),
                            // ),
                            DataColumn(
                              label: Text(
                                "Edit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            userList.length,
                            (index) {

                              return DataRow(
                                color: index.isOdd
                                    ? MaterialStateProperty.all(Colors
                                        .blueGrey.shade50
                                        .withOpacity(0.7))
                                    : MaterialStateProperty.all(
                                        Colors.blueGrey.shade50),
                                cells: [
                                  DataCell(SelectableText(
                                    userList[index]['display_name'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(Text(
                                    userList[index]['email'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    userList[index]['mobileNumber'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    userList[index]['role'],
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


                                          if(userList[index]['verified']==true){
                                            print('sssss');

                                            FirebaseFirestore.instance
                                                .collection('admin_users')
                                            .doc(userList[index]['uid'])
                                                .update({
                                              'verified': !userList[index]['verified'],
                                            });

                                            FirebaseFirestore.instance
                                                .collection('branch')
                                                .doc(currentbranchId)
                                                .update({
                                              'staff': FieldValue.arrayRemove([userList[index]['email']]),
                                            });

                                          }else{
                                            print('nnnnn');
                                            FirebaseFirestore.instance
                                                .collection('admin_users')
                                                .doc(userList[index]['uid'])
                                                .update({
                                              'verified': !userList[index]['verified'],
                                            });

                                            FirebaseFirestore.instance
                                                .collection('branch')
                                                .doc(currentbranchId)
                                                .update({
                                              'staff': FieldValue.arrayUnion([userList[index]['email']]),
                                            });

                                          }

                                        }

                                      },
                                      text: userList[index]['verified'] == true
                                          ? 'Veryfied'
                                          : 'Blocked',
                                      options: FFButtonOptions(
                                        width: 80,
                                        height: 30,
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.subtitle2
                                            .override(
                                                fontFamily: 'Poppins',
                                                color: userList[index]['verified'] == true
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
                                  // DataCell(InkWell(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => UserDetails(
                                  //                   userId: data.id,
                                  //                 )));
                                  //   },
                                  //   child: Container(
                                  //     height: 40,
                                  //     width: 100,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       color: Colors.teal,
                                  //     ),
                                  //     child: Center(
                                  //       child: Text(
                                  //         'View',
                                  //         style: FlutterFlowTheme.bodyText2
                                  //             .override(
                                  //           fontFamily: 'Lexend Deca',
                                  //           color: Colors.white,
                                  //           fontSize: 11,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )),
                                  DataCell(InkWell(
                                    onTap: () {
                                    edit=true;
                                    editName.text=userList[index]['display_name'];
                                    editEmail.text=userList[index]['email'];
                                    editPhone.text=userList[index]['mobileNumber'];
                                    editUserRole=userList[index]['role'];
                                    editUserName.text=userList[index]['userName'];
                                    editPassword.text=userList[index]['password'];
                                    editUserId=userList[index]['uid'];
                                    editFileUrl=userList[index]['photo_url'];

                                    setState(() {

                                    });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit),
                                            Text(
                                              'Edit',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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

              SizedBox(
                height: 20,
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

                  userList.length<limit||userList.length==0?
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
