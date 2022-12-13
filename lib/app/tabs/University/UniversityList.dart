// import 'package:smile_erp/app/pages/home_page/home.dart';
// import 'package:smile_erp/app/tabs/University/university_singlePage.dart';
// import 'package:smile_erp/backend/backend.dart';
// import 'package:smile_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:smile_erp/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'Details/EditUniversity.dart';
// import '../Student/StudentSinglePageView.dart';
// import '../Student/createPopup.dart';
//
// class UniversityList extends StatefulWidget {
//   const UniversityList({Key key}) : super(key: key);
//
//   @override
//   _UniversityListState createState() => _UniversityListState();
// }
//
// class _UniversityListState extends State<UniversityList> {
//   TextEditingController search;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   List<DropdownMenuItem> listofcategory;
//   List<DropdownMenuItem> listofSubcategory;
//   String selectedCategory = '';
//   String selectedSubCategory = '';
//
//   var data;
//
//   String selectedCategoryId = "";
//   List<DropdownMenuItem> categoryTemp = [];
//   @override
//   void initState() {
//     super.initState();
//     search = TextEditingController();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Education Board',
//                       style: FlutterFlowTheme.bodyText1.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 30,
//                           fontWeight: FontWeight.w600
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
//                   child: Container(
//                     width: 600,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 3,
//                           color: Color(0x39000000),
//                           offset: Offset(0, 1),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
//                               child: TextFormField(
//                                 controller: search,
//                                 onChanged: (text){
//                                   setState(() {
//
//                                   });
//                                 },
//                                 obscureText: false,
//                                 decoration: InputDecoration(
//                                   labelText: 'Search',
//                                   hintText: 'Please Enter Name',
//                                   labelStyle: FlutterFlowTheme
//                                       .bodyText2
//                                       .override(
//                                     fontFamily: 'Poppins',
//                                     color: Color(0xFF7C8791),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                                 style: FlutterFlowTheme
//                                     .bodyText1
//                                     .override(
//                                   fontFamily: 'Poppins',
//                                   color: Color(0xFF090F13),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                             child: FFButtonWidget(
//                               onPressed: ()  {
//
//                                 search.clear();
//                                 setState(() {
//
//                                 });
//
//                               },
//                               text: 'Clear',
//                               options: FFButtonOptions(
//                                 width: 100,
//                                 height: 40,
//                                 color: Color(0xFF4B39EF),
//                                 textStyle: FlutterFlowTheme
//                                     .subtitle2
//                                     .override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                                 elevation: 2,
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                                 borderRadius: 50,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//
//             search.text==''?
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance.collection('university').snapshots(),
//                   builder: (context, snapshot) {
//                     if(!snapshot.hasData){
//                       return Center(child: CircularProgressIndicator());
//                     }
//                      data=snapshot.data.docs;
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         width: double.infinity,
//
//                         child: SingleChildScrollView(
//
//                           physics: BouncingScrollPhysics(),
//                           child: DataTable(
//                             horizontalMargin: 8,
//                             columns: [
//
//                               DataColumn(
//                                 label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
//                               ),
//                               DataColumn(
//                                 label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                               DataColumn(
//                                 label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                               DataColumn(
//                                 label: Text(""),
//                               ),
//                               DataColumn(
//                                 label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                             ],
//                             rows: List.generate(
//                               data.length,
//                                   (index) {
//
//                                 String name=data[index]['name'];
//                                 String email=data[index]['email'];
//                                 String imageUrl1=data[index]['logo'];
//
//
//
//
//
//                                 return DataRow(
//                                   color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
//
//                                   cells: [
//                                     DataCell(Text((index+1).toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(Text(name,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(Text(email,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(  Row(
//                                       children: [
//
//                                       ],
//                                     ),),
//                                     DataCell(   Row(
//                                       children: [
//                                         FFButtonWidget(
//                                           onPressed: ()  {
//
//                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>UniversitySinglePage(
//                                               id: data[index].id,
//                                             )));
//
//                                           },
//                                           text: 'View',
//                                           options: FFButtonOptions(
//                                             width: 80,
//                                             height: 30,
//                                             color: Colors.teal,
//                                             textStyle: FlutterFlowTheme.subtitle2.override(
//                                               fontFamily: 'Poppins',
//                                               color: Colors.white,
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold
//                                             ),
//                                             borderSide: BorderSide(
//                                               color: Colors.transparent,
//                                               width: 1,
//                                             ),
//                                             borderRadius: 8,
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),),
//                                     // DataCell(Text(fileInfo.size)),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//               ),
//             ):
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance.collection('university')
//                   .where('search',arrayContains: search.text.toUpperCase())
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if(!snapshot.hasData){
//                       return Center(child: CircularProgressIndicator());
//                     }
//                      data=snapshot.data.docs;
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         width: double.infinity,
//
//                         child: SingleChildScrollView(
//
//                           physics: BouncingScrollPhysics(),
//                           child: DataTable(
//                             horizontalMargin: 8,
//                             columns: [
//
//                               DataColumn(
//                                 label: Text("Sl.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
//                               ),
//                               DataColumn(
//                                 label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                               DataColumn(
//                                 label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                               DataColumn(
//                                 label: Text(""),
//                               ),
//                               DataColumn(
//                                 label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
//                               ),
//                             ],
//                             rows: List.generate(
//                               data.length,
//                                   (index) {
//
//                                 String name=data[index]['name'];
//                                 String email=data[index]['email'];
//                                 String imageUrl1=data[index]['logo'];
//
//
//                                 return DataRow(
//                                   color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
//
//                                   cells: [
//                                     DataCell(Text((index+1).toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(Text(name,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(Text(email,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
//                                     DataCell(  Row(
//                                       children: [
//
//                                       ],
//                                     ),),
//                                     DataCell(   Row(
//                                       children: [
//                                         FFButtonWidget(
//                                           onPressed: ()  {
//
//                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUniversity(
//                                               id: data[index].id,
//                                             )));
//
//
//                                           },
//                                           text: 'View',
//                                           options: FFButtonOptions(
//                                             width: 80,
//                                             height: 30,
//                                             color: Colors.teal,
//                                             textStyle: FlutterFlowTheme.subtitle2.override(
//                                                 fontFamily: 'Poppins',
//                                                 color: Colors.white,
//                                                 fontSize: 11,
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                             borderSide: BorderSide(
//                                               color: Colors.transparent,
//                                               width: 1,
//                                             ),
//                                             borderRadius: 8,
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),),
//                                     // DataCell(Text(fileInfo.size)),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
