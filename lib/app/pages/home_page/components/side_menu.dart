import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_erp/Login/login.dart';
import 'package:smile_erp/auth/auth_util.dart';
import '../../../components/colapseItem.dart';
import '../home.dart';
import 'user_profile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  _SideMenuState createState() => _SideMenuState();
}
int selectedTab=0;
int subTab=0;
class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff062944),
      width: 240,
      child: Theme(
        data: ThemeData(highlightColor:  Color(0xff062944),),
        child: Scrollbar(
          child: ListView(
            children: [
              SizedBox(height: 10),
              UserProfile(),
              currentUserRole=='Super Admin'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )),
                  Divider(color: Colors.blueGrey.shade800,),
                  //STUDENT
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab=3;
                                subTab=5;
                              });},
                                  child: ColaspeItem(label: "Student List", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==5? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==5? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((18));
                                selectedTab=3;
                                subTab=18;
                              });},
                                  child: ColaspeItem(label: "Student Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==18? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==18? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((19));
                                selectedTab=3;
                                subTab=19;
                              });},
                                  child: ColaspeItem(label: "Rejected Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==19? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                                  ),)),


                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //TEACHER
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Teacher",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((12));
                                  selectedTab=4;
                                  subTab=12;
                                });
                              },
                                  child: ColaspeItem(label: "Batch", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==12? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==12? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((6));
                                  selectedTab=4;
                                  subTab=6;
                                });
                              },
                                  child: ColaspeItem(label: "New Schedules", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==6? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==6? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //REPORT
                  InkWell(
                    onTap: () {

                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==5? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.inbox,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((17));
                                  selectedTab=5;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Enquiry Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==17? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==17? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((7));
                                  selectedTab=5;
                                  subTab=7;
                                });
                              },
                                  child: ColaspeItem(label: "Fee Due Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((15));
                                  selectedTab=5;
                                  subTab=15;
                                });
                              },
                                  child: ColaspeItem(label: "Admission Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==15? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==15? FontWeight.bold:FontWeight.normal
                                  ),)),
                              // InkWell( onTap: () {
                              //   setState(() {
                              //     widget._tabController.animateTo((19));
                              //     selectedTab=5;
                              //     subTab=19;
                              //   });
                              // },
                              //     child: ColaspeItem(label: "Registration Report", icon: Icons.stop_rounded,style: TextStyle(
                              //         color:subTab==19? Colors.blue.shade300 : Colors.grey,
                              //         fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                              //     ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //USER
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==6? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Users",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((8));
                                  selectedTab=6;
                                  subTab=8;
                                });
                              },
                                  child: ColaspeItem(label: "Add", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==8? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==8? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ACCOUNTS
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==7? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((13));
                                  selectedTab=7;
                                  subTab=13;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Expense Head", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==13? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==13? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((14));
                                  selectedTab=7;
                                  subTab=14;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Add Expense", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==14? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==14? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //SETTINGS
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==8? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.report,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded:  Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [

                              InkWell( onTap:(){ setState(() {
                                print(selectedTab);
                                print(subTab);
                                widget._tabController.animateTo((9));
                                selectedTab=8;
                                subTab=9;
                              });},child: ColaspeItem(label: "Add Course", icon: Icons.stop_rounded,style: TextStyle(
                                  color:subTab==9? Colors.blue.shade300 : Colors.grey,
                                  fontWeight:subTab==9? FontWeight.bold:FontWeight.normal
                              ),)),
                              InkWell( onTap:(){ setState(() {
                                print(selectedTab);
                                print(subTab);
                                widget._tabController.animateTo((1));
                                selectedTab=8;
                                subTab=1;
                              });},child: ColaspeItem(label: "Add Tutor", icon: Icons.stop_rounded,style: TextStyle(
                                  color:subTab==1? Colors.blue.shade300 : Colors.grey,
                                  fontWeight:subTab==1? FontWeight.bold:FontWeight.normal
                              ),)),
                              InkWell( onTap:(){ setState(() {
                                print(subTab);
                                widget._tabController.animateTo((11));
                                selectedTab=8;
                                subTab=11;
                              });},
                                  child: ColaspeItem(label: "InTakes", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==11? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==11? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap:(){ setState(() {
                                widget._tabController.animateTo((10));
                                selectedTab=8;
                                subTab=10;
                              });},child: ColaspeItem(label: "Education Board", icon: Icons.stop_rounded,style: TextStyle(
                                  color:subTab==10? Colors.blue.shade300 : Colors.grey,
                                  fontWeight:subTab==10? FontWeight.bold:FontWeight.normal
                              ),)),
                              InkWell( onTap:(){ setState(() {
                                widget._tabController.animateTo((16));
                                selectedTab=8;
                                subTab=16;
                              });},child: ColaspeItem(label: "Department", icon: Icons.stop_rounded,style: TextStyle(
                                  color:subTab==16? Colors.blue.shade300 : Colors.grey,
                                  fontWeight:subTab==16? FontWeight.bold:FontWeight.normal
                              ),)),
                              InkWell( onTap:(){ setState(() {
                                widget._tabController.animateTo((20));
                                selectedTab=8;
                                subTab=20;
                              });},child: ColaspeItem(label: "Customer Support", icon: Icons.stop_rounded,style: TextStyle(
                                  color:subTab==20? Colors.blue.shade300 : Colors.grey,
                                  fontWeight:subTab==20? FontWeight.bold:FontWeight.normal
                              ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(alertDialogContext);
                                  final SharedPreferences userDatas= await SharedPreferences.getInstance();
                                  userDatas.remove('id');
                                  userDatas.remove('name');
                                  userDatas.remove('role');
                                  userDatas.remove('userEmail');
                                  userDatas.remove('userName');
                                  // await signOut();
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )

                  :currentUserRole=='Happiness Officer'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //STUDENT
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                  onTap:(){ setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab=3;
                                subTab=5;
                              });},
                                  child: ColaspeItem(label: "Student List", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==5? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==5? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((18));
                                selectedTab=3;
                                subTab=18;
                              });},
                                  child: ColaspeItem(label: "Student Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==18? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==18? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((19));
                                selectedTab=3;
                                subTab=19;
                              });},
                                  child: ColaspeItem(label: "Rejected Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==19? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //TEACHER
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Teacher",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((12));
                                  selectedTab=4;
                                  subTab=12;
                                });
                              },
                                  child: ColaspeItem(label: "Batch", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==12? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==12? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((6));
                                  selectedTab=4;
                                  subTab=6;
                                });
                              },
                                  child: ColaspeItem(label: "New Schedules", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==6? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==6? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                   Navigator.pop(alertDialogContext);
                                   final SharedPreferences userDatas= await SharedPreferences.getInstance();
                                   userDatas.remove('id');
                                   userDatas.remove('name');
                                   userDatas.remove('role');
                                   userDatas.remove('userEmail');
                                   userDatas.remove('userName');
                                  // await signOut();
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )

                  :currentUserRole=='coordinator'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          print(selectedTab);
                          print(subTab);
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )),
                  Divider(color: Colors.blueGrey.shade800,),
                  //STUDENT
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab=3;
                                subTab=5;
                              });},
                                  child: ColaspeItem(label: "Student List", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==5? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==5? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((18));
                                selectedTab=3;
                                subTab=18;
                              });},
                                  child: ColaspeItem(label: "Student Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==18? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==18? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((19));
                                selectedTab=3;
                                subTab=19;
                              });},
                                  child: ColaspeItem(label: "Rejected Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==19? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                                  ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //TEACHER
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Teacher",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((12));
                                  selectedTab=4;
                                  subTab=12;
                                });
                              },
                                  child: ColaspeItem(label: "Batch", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==12? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==12? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((6));
                                  selectedTab=4;
                                  subTab=6;
                                });
                              },
                                  child: ColaspeItem(label: "New Schedules", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==6? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==6? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //REPORT
                  InkWell(
                    onTap: () {

                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==5? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.inbox,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((17));
                                  selectedTab=5;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Enquiry Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((7));
                                  selectedTab=5;
                                  subTab=7;
                                });
                              },
                                  child: ColaspeItem(label: "Fee Due Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),)
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((15));
                                  selectedTab=5;
                                  subTab=15;
                                });
                              },
                                  child: ColaspeItem(label: "Admission Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==15? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==15? FontWeight.bold:FontWeight.normal
                                  ),)),
                              // InkWell( onTap: () {
                              //   setState(() {
                              //     widget._tabController.animateTo((19));
                              //     selectedTab=5;
                              //     subTab=19;
                              //   });
                              // },
                              //     child: ColaspeItem(label: "Registration Report", icon: Icons.stop_rounded,style: TextStyle(
                              //         color:subTab==19? Colors.blue.shade300 : Colors.grey,
                              //         fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                              //     ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //USER
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==6? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Users",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((8));
                                  selectedTab=6;
                                  subTab=8;
                                });
                              },
                                  child: ColaspeItem(label: "Add", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==8? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==8? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ACCOUNTS
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==7? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((13));
                                  selectedTab=7;
                                  subTab=13;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Expense Head", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==13? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==13? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((14));
                                  selectedTab=7;
                                  subTab=14;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Add Expense", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==14? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==14? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(alertDialogContext);
                                  final SharedPreferences userDatas= await SharedPreferences.getInstance();
                                  userDatas.remove('id');
                                  userDatas.remove('name');
                                  userDatas.remove('role');
                                  userDatas.remove('userEmail');
                                  userDatas.remove('userName');
                                  // await signOut();
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )

                  :currentUserRole=='Reception'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )),
                  Divider(color: Colors.blueGrey.shade800,),
                  //STUDENT
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab=3;
                                subTab=5;
                              });},
                                  child: ColaspeItem(label: "Student List", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==5? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==5? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((18));
                                selectedTab=3;
                                subTab=18;
                              });},
                                  child: ColaspeItem(label: "Student Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==18? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==18? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((19));
                                selectedTab=3;
                                subTab=19;
                              });},
                                  child: ColaspeItem(label: "Rejected Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==19? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                                  ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ACCOUNTS
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((13));
                                  selectedTab=4;
                                  subTab=13;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Expense Head", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==13? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==13? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((14));
                                  selectedTab=4;
                                  subTab=14;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Add Expense", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==14? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==14? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //REPORT
                  InkWell(
                    onTap: () {

                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==5? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.inbox,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((17));
                                  selectedTab=5;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Enquiry Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==17? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==17? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((7));
                                  selectedTab=5;
                                  subTab=7;
                                });
                              },
                                  child: ColaspeItem(label: "Fee Due Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),)
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((15));
                                  selectedTab=5;
                                  subTab=15;
                                });
                              },
                                  child: ColaspeItem(label: "Admission Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==15? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==15? FontWeight.bold:FontWeight.normal
                                  ),)),
                              // InkWell( onTap: () {
                              //   setState(() {
                              //     widget._tabController.animateTo((19));
                              //     selectedTab=5;
                              //     subTab=19;
                              //   });
                              // },
                              //     child: ColaspeItem(label: "Registration Report", icon: Icons.stop_rounded,style: TextStyle(
                              //         color:subTab==19? Colors.blue.shade300 : Colors.grey,
                              //         fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                              //     ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                   Navigator.pop(alertDialogContext);
                                  // await signOut();
                                   final SharedPreferences userDatas= await SharedPreferences.getInstance();
                                   userDatas.remove('id');
                                   userDatas.remove('name');
                                   userDatas.remove('role');
                                   userDatas.remove('userEmail');
                                   userDatas.remove('userName');
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )

                  :currentUserRole=='Councilor'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )),
                  Divider(color: Colors.blueGrey.shade800,),
                  //STUDENT
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab=3;
                                subTab=5;
                              });},
                                  child: ColaspeItem(label: "Student List", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==5? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==5? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((18));
                                selectedTab=3;
                                subTab=18;
                              });},
                                  child: ColaspeItem(label: "Student Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==18? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==18? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell(      onTap:(){ setState(() {
                                widget._tabController.animateTo((19));
                                selectedTab=3;
                                subTab=19;
                              });},
                                  child: ColaspeItem(label: "Rejected Request", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==19? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //REPORT
                  InkWell(
                    onTap: () {

                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.inbox,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((17));
                                  selectedTab=4;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Enquiry Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((7));
                                  selectedTab=4;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Fee Due Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==17? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==17? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((15));
                                  selectedTab=4;
                                  subTab=15;
                                });
                              },
                                  child: ColaspeItem(label: "Admission Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==15? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==15? FontWeight.bold:FontWeight.normal
                                  ),)),
                              // InkWell( onTap: () {
                              //   setState(() {
                              //     widget._tabController.animateTo((19));
                              //     selectedTab=5;
                              //     subTab=19;
                              //   });
                              // },
                              //     child: ColaspeItem(label: "Registration Report", icon: Icons.stop_rounded,style: TextStyle(
                              //         color:subTab==19? Colors.blue.shade300 : Colors.grey,
                              //         fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                              //     ),)),
                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //LOGOUT
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Logout !'),
                            content: Text('Do you Want to Logout ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                   Navigator.pop(alertDialogContext);
                                  // await signOut();
                                   final SharedPreferences userDatas= await SharedPreferences.getInstance();
                                   userDatas.remove('id');
                                   userDatas.remove('name');
                                   userDatas.remove('role');
                                   userDatas.remove('userEmail');
                                   userDatas.remove('userName');
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CustomSideMenuItem(
                      title: 'Logout',
                      icon: Icons.logout,
                    ),
                  )
                ],
              )

                  :currentUserRole=='tutor'?
              Column(
                children: [
                  Divider(color: Colors.blueGrey.shade800,),
                  //DASHBOARD
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:selectedTab==0? Border(
                        left: BorderSide(
                          color: Color(0xff0087cd),
                          width: 3,
                        ),
                      ):null,
                    ),
                    // color: Color(0xFF1a2226),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget._tabController.animateTo((0));
                          selectedTab=0;
                          subTab=0;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ENQUIRY
                  ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.white,
                        iconSize: 14,
                      ),
                      header: Container(
                        height: 30,
                        decoration: BoxDecoration(

                          border:selectedTab==2? Border(
                            left: BorderSide(
                              color: Color(0xff0087cd),
                              width: 3,
                            ),
                          ):null,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.category,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [

                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((2));
                              selectedTab=2;
                              subTab=2;
                            });},child: ColaspeItem(label: "Add Enquiry", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==2? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==2? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((3));
                              selectedTab=2;
                              subTab=3;
                            });},child: ColaspeItem(label: "Enquiry List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==3? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==3? FontWeight.bold:FontWeight.normal
                            ),)),
                            InkWell( onTap:(){ setState(() {
                              widget._tabController.animateTo((4));
                              selectedTab=2;
                              subTab=4;
                            });},child: ColaspeItem(label: "FollowUp List", icon: Icons.stop_rounded,style: TextStyle(
                                color:subTab==4? Colors.blue.shade300 : Colors.grey,
                                fontWeight:subTab==4? FontWeight.bold:FontWeight.normal
                            ),)),

                          ],
                        ),
                      )),
                  Divider(color: Colors.blueGrey.shade800,),
                  //ACCOUNTS
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget._tabController.animateTo((0));
                      });
                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==3? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_pin_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((13));
                                  selectedTab=3;
                                  subTab=13;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Expense Head", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==13? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==13? FontWeight.bold:FontWeight.normal
                                  ),)),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((14));
                                  selectedTab=3;
                                  subTab=14;
                                });
                                print(selectedTab);
                                print(subTab);
                              },
                                  child: ColaspeItem(label: "Add Expense", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==14? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==14? FontWeight.bold:FontWeight.normal
                                  ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                  //REPORT
                  InkWell(
                    onTap: () {

                    },
                    child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.white,
                          iconSize: 14,
                        ),
                        header: Container(
                          height: 30,
                          decoration: BoxDecoration(

                            border:selectedTab==4? Border(
                              left: BorderSide(
                                color: Color(0xff0087cd),
                                width: 3,
                              ),
                            ):null,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.inbox,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((17));
                                  selectedTab=4;
                                  subTab=17;
                                });
                              },
                                  child: ColaspeItem(label: "Enquiry Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==17? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==17? FontWeight.bold:FontWeight.normal
                                  ),
                                  )
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((7));
                                  selectedTab=4;
                                  subTab=7;
                                });
                              },
                                  child: ColaspeItem(label: "Fee Due Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),)
                              ),
                              InkWell( onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((15));
                                  selectedTab=4;
                                  subTab=7;
                                });
                              },
                                  child: ColaspeItem(label: "Admission Report", icon: Icons.stop_rounded,style: TextStyle(
                                      color:subTab==7? Colors.blue.shade300 : Colors.grey,
                                      fontWeight:subTab==7? FontWeight.bold:FontWeight.normal
                                  ),)),
                              // InkWell( onTap: () {
                              //   setState(() {
                              //     widget._tabController.animateTo((19));
                              //     selectedTab=5;
                              //     subTab=19;
                              //   });
                              // },
                              //     child: ColaspeItem(label: "Registration Report", icon: Icons.stop_rounded,style: TextStyle(
                              //         color:subTab==19? Colors.blue.shade300 : Colors.grey,
                              //         fontWeight:subTab==19? FontWeight.bold:FontWeight.normal
                              //     ),)),

                            ],
                          ),
                        )),
                  ),
                  Divider(color: Colors.blueGrey.shade800,),
                ],
              )

                  :Container()

            ],
          ),
        ),
      ),
    );
  }


}

class CustomSideMenuItem extends StatelessWidget {
  const CustomSideMenuItem({
    Key key,
    this.icon,
    this.iconSize = 18,
    this.iconColor = Colors.white,
    this.title,
    this.titleStyle,
    this.onTap, this.backColor,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backColor;
  final String title;
  final TextStyle titleStyle;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        color: backColor,
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
