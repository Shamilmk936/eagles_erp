
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smile_erp/app/tabs/University/university_singlePage.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../backend/schema/index.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import 'Details/EditUniversity.dart';

class AddUniversity extends StatefulWidget {
  const AddUniversity({Key key}) : super(key: key);

  @override
  _AddUniversityState createState() => _AddUniversityState();
}

class _AddUniversityState extends State<AddUniversity> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name;
  TextEditingController email;
  TextEditingController address;
  TextEditingController image;
  TextEditingController search;
  String logo='';
  String banner='';
  bool edit=false;
  String currentId='';
  String currentName='';
  String currentImage='';


  //while editing
  TextEditingController eName;
  TextEditingController eEmail;
  TextEditingController eImage;
  TextEditingController eAddress;
  String eUploadedFileUrl1='';



List data=[];

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    search = TextEditingController();
    eName = TextEditingController(text: currentName);
    eEmail = TextEditingController(text: currentName);
    image = TextEditingController(text: logo);
    eImage = TextEditingController(text: eUploadedFileUrl1);
    eAddress = TextEditingController();
  }
  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Education Board',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: name,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              hintText: 'Please Enter University Name',
                                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF252525),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF252525),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            style: FlutterFlowTheme.bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30,),
                                        Expanded(
                                          child: TextFormField(
                                            controller: email,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              hintText: 'Please Enter University Email',
                                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF252525),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF252525),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            style: FlutterFlowTheme.bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: address,
                                      obscureText: false,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                        hintText: 'Please Enter University Address',
                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF252525),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF252525),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    banner==''?Text('Please Upload Banner'):
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          height: 100,
                                          width: 100,
                                          child: CachedNetworkImage(imageUrl: banner)),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final selectedMedia = await selectMedia(
                                          maxWidth: 1080.00,
                                          maxHeight: 1320.00,
                                        );
                                        if (selectedMedia != null &&
                                            validateFileFormat(
                                                selectedMedia.storagePath, context)) {
                                          showUploadMessage(context, 'Uploading file...',
                                              showLoading: true);
                                          final downloadUrl = await uploadData(
                                              selectedMedia.storagePath,
                                              selectedMedia.bytes);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          if (downloadUrl != null) {
                                            setState(
                                                    () {
                                                  banner = downloadUrl;
                                                } );
                                            showUploadMessage(context, 'Success!');
                                          } else {
                                            showUploadMessage(
                                                context, 'Failed to upload media');
                                          }
                                        }
                                      },
                                      text: banner==''?'Upload Banner':'Change Banner',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 40,
                                        color: Color(0xFF090F13),
                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    logo==''?Text('Please Upload Logo'):
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          height: 100,
                                          width: 100,
                                          child: CachedNetworkImage(imageUrl: logo)),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final selectedMedia = await selectMedia(
                                          maxWidth: 1080.00,
                                          maxHeight: 1320.00,
                                        );
                                        if (selectedMedia != null &&
                                            validateFileFormat(
                                                selectedMedia.storagePath, context)) {
                                          showUploadMessage(context, 'Uploading file...',
                                              showLoading: true);
                                          final downloadUrl = await uploadData(
                                              selectedMedia.storagePath,
                                              selectedMedia.bytes);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          if (downloadUrl != null) {
                                            setState(
                                                    () {
                                                  logo = downloadUrl;
                                                  image.text= logo;
                                                } );
                                            showUploadMessage(context, 'Success!');
                                          } else {
                                            showUploadMessage(
                                                context, 'Failed to upload media');
                                          }
                                        }
                                      },
                                      text: logo==''?'Upload Logo':'Change Logo',
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 40,
                                        color: Color(0xFF090F13),
                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
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

                          ],
                        ),
                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {

                                if (name.text!=''&& email.text!=''&&address.text!=''&&logo!='') {

                                  bool proceed = await alert(context,
                                      'You want to Add this University?');

                                  if (proceed) {

                                    FirebaseFirestore.instance.collection('university').add({
                                      'verify':true,
                                      'name':name.text,
                                      'email':email.text,
                                      'address':address.text,
                                      'logo':logo,
                                      'banner':banner,
                                      'search':setSearchParam(name.text),
                                      'courses':[],
                                      'courseList':[],

                                    });
                                    showUploadMessage(
                                        context, 'New University Added...!');
                                    setState(() {

                                      logo='';
                                      name.text='';
                                      image.text='';
                                      banner='';
                                      address.text='';
                                      email.text='';


                                    });
                                  }


                                } else {

                                  name.text==''? showUploadMessage(context, "Please Enter University name"):
                                  email.text==''? showUploadMessage(context, "Please Enter University Email"):
                                  address.text==''? showUploadMessage(context, "Please Enter University Address"):
                                  showUploadMessage(context, 'Please Upload Logo');

                                }
                              },
                              text: 'Add University',
                              options: FFButtonOptions(
                                width: 180,
                                height: 50,
                                color: Colors.teal,
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                            SizedBox(width: 50,),

                          ],
                        ),

                      ],
                    )
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Education Board List',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  onChanged: (text){
                                    setState(() {

                                    });
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Please Enter Name',
                                    labelStyle: FlutterFlowTheme
                                        .bodyText2
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: ()  {

                                  search.clear();
                                  setState(() {

                                  });

                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xFF4B39EF),
                                  textStyle: FlutterFlowTheme
                                      .subtitle2
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              search.text==''?
              SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('university').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      data=snapshot.data.docs;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,

                          child: SingleChildScrollView(

                            physics: BouncingScrollPhysics(),
                            child: DataTable(
                              horizontalMargin: 8,
                              columns: [

                                DataColumn(
                                  label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                ),
                                DataColumn(
                                  label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                              ],
                              rows: List.generate(
                                data.length,
                                    (index) {

                                  String name=data[index]['name'];
                                  String email=data[index]['email'];
                                  String imageUrl1=data[index]['logo'];

                                  return DataRow(
                                    color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                    cells: [
                                      DataCell(Text((index+1).toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(Text(name,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(Text(email,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(  Row(
                                        children: [

                                        ],
                                      ),),
                                      DataCell(   Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: ()  {

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UniversitySinglePage(
                                                id: data[index].id,
                                              )));

                                            },
                                            text: 'View',
                                            options: FFButtonOptions(
                                              width: 80,
                                              height: 30,
                                              color: Colors.teal,
                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 8,
                                            ),
                                          ),

                                        ],
                                      ),),
                                      // DataCell(Text(fileInfo.size)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ):
              SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('university')
                        .where('search',arrayContains: search.text.toUpperCase())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      data=snapshot.data.docs;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,

                          child: SingleChildScrollView(

                            physics: BouncingScrollPhysics(),
                            child: DataTable(
                              horizontalMargin: 8,
                              columns: [

                                DataColumn(
                                  label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                ),
                                DataColumn(
                                  label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                              ],
                              rows: List.generate(
                                data.length,
                                    (index) {

                                  String name=data[index]['name'];
                                  String email=data[index]['email'];
                                  String imageUrl1=data[index]['logo'];


                                  return DataRow(
                                    color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                    cells: [
                                      DataCell(Text((index+1).toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(Text(name,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(Text(email,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                                      DataCell(  Row(
                                        children: [

                                        ],
                                      ),),
                                      DataCell(   Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: ()  {

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUniversity(
                                                id: data[index].id,
                                              )));


                                            },
                                            text: 'View',
                                            options: FFButtonOptions(
                                              width: 80,
                                              height: 30,
                                              color: Colors.teal,
                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 8,
                                            ),
                                          ),

                                        ],
                                      ),),
                                      // DataCell(Text(fileInfo.size)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
