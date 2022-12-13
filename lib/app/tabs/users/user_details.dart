import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';

class UserDetails extends StatefulWidget {
  final String userId;
  const UserDetails({Key key, this.userId,}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('admin_users').doc(widget.userId).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          var userData=snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFECF0F5),
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: true,
              title: Text(
                userData['display_name'],
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
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height,
                              child:  Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: MediaQuery.of(context).size.width*0.1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        userData['photo_url']==''?
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.1,

                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png',
                                          ),
                                        ):
                                        Container(
                                          height: MediaQuery.of(context).size.width*1,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:userData['photo_url'],
                                          ),
                                        ),

                                        Container(
                                          // color: Colors.green,
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
                                                    child: Text('${userData['display_name']}'
                                                      ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.email,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(userData['email'])),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.phone,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(userData['mobileNumber'])),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(width: MediaQuery.of(context).size.width*0.05,child: Icon(Icons.account_balance_outlined,size: 20,color: Colors.black,)),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,child: Text(userData['role'])),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height,

                            ),
                          ),
                        ),
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
