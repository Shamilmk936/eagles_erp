import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smile_erp/app/app_widget.dart';
import 'package:smile_erp/app/tabs/Settings/AddCourse.dart';
import 'package:smile_erp/app/tabs/Enquiry/AddEnquiry.dart';
import 'package:smile_erp/auth/auth_util.dart';
import 'package:multiple_select/Item.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../tabs/Accounts/add_expense.dart';
import '../../tabs/Accounts/add_expense_head.dart';
import '../../tabs/Branch/AddBranch.dart';
import '../../tabs/Classes/new_schedules.dart';
import '../../tabs/Enquiry/followUp.dart';
import '../../tabs/Classes/AddClass.dart';
import '../../tabs/Reports/admissionReport.dart';
import '../../tabs/Enquiry/EnquiryList.dart';
import '../../tabs/InTake/InTake.dart';
import '../../tabs/Reports/enquiry_report.dart';
import '../../tabs/Reports/feeDue_report.dart';
import '../../tabs/Settings/add_department.dart';
import '../../tabs/Settings/add_tutor.dart';
import '../../tabs/Student/StudentsLists.dart';
import '../../tabs/Student/rejected_students.dart';
import '../../tabs/Student/student_request.dart';
import '../../tabs/University/AddUniversities.dart';
import '../../tabs/University/UniversityList.dart';
import '../../tabs/homeTab.dart';
import '../../tabs/users/addBranchUser.dart';
import 'components/side_menu.dart';

bool order=false;

List<Item> intakeMultiple = [];



List <String> applicationStatusList=[
  'Select status'
];

Map<String,dynamic>intakeById={};
Map<String,dynamic>currentUserMap={};
Map<String,dynamic>currentUserIdToName={};
Map<String,dynamic>idByIntake={};
List<String> countryList=['Select Country'];

List<String> universityCourses=['Select Course'];


Map<String, dynamic> courseIdByName = {};
Map<String, dynamic> courseMap = {};

Map<String , dynamic> CourseNameToId ={};
Map<String , dynamic> CourseIdToName ={};
Map<String , dynamic> CourseIdToType ={};
Map<String , dynamic> CourseIdToDuration ={};
Map<String , dynamic> CourseFee ={};
List <String> courses = ['Select Course'];
getSelectedCourse() {
  FirebaseFirestore.instance.collection("course")
      .where('delete',isEqualTo: false)
      .snapshots()
      .listen((event) {
    courses=[];
    for (DocumentSnapshot doc in event.docs) {
      CourseNameToId[doc.get('name')]=doc.id;
      CourseIdToName[doc.id]=doc.get('name');
      CourseIdToType[doc.id]=doc.get('courseType');
      // CourseIdToDuration[doc.id]=doc.get('duration');
      // CourseFee[doc.get('name')]=doc.get('fees');
      courses.add(doc['name']);
      // print(courses);
    }
  });
}

Map<String , dynamic> branchNameMap ={};
Map<String , dynamic> branchShortNameMap ={};
Map<String , dynamic> branchIdMap ={};
Map<String , dynamic> branchIdToName ={};
List<String>branches=['select branch'];
getBranches() {
  FirebaseFirestore.instance.collection("branch").snapshots().listen((event) {
    branches=[];
    for (var doc in event.docs) {
      branchIdMap[doc.id]=doc.data();
      branchIdToName[doc.id]=doc.get('name');
      branchNameMap[doc.get('name')]=doc.get('branchId');
      branchShortNameMap[doc.get('name')]=doc.get('shortName');

      branches.add(doc.get('name'),);
    }
  });

}

Map<String , dynamic> ClassNameToId ={};
Map<String , dynamic> ClassIdToName ={};
Map<String , dynamic> classMap ={};
List<String> classes=[];
getClasses(){
  FirebaseFirestore.instance
      .collection('class')
      .where('available',isEqualTo: true)
      .snapshots()
      .listen((event) {
    classes=[];
    classes.add('All Batches');
        for(var data in event.docs){
          classMap[data.id]=data.data();
          ClassNameToId[data.get('name')]=data.id;
          ClassIdToName[data.id]=data.get('name');
          classes.add(data['name']);

        }
        print(classes);
        print('kkkkkk');
  });
}

Map<String , dynamic> InTakeNameToId ={};
Map<String , dynamic> InTakeIdToName ={};
List <String> inTakes = ['Select Intakes'];
getSelectedInTake() {
  FirebaseFirestore.instance.collection("intakes")
      .where('available',isEqualTo: true)
      .snapshots().listen((event) {
    inTakes=[];
    for (DocumentSnapshot doc in event.docs) {
      print(dateTimeFormat('MMMM yyyy', doc['intake'].toDate()),);
      InTakeNameToId[doc.get('intakeName')]=doc.id;
      InTakeIdToName[doc.id]=doc.get('intakeName');
      inTakes.add(doc.get('intakeName'));
      // InTakeNameToId[(dateTimeFormat('MMMM yyyy', doc['intake'].toDate())).toString()]=doc.id;
      // InTakeIdToName[doc.id]=(dateTimeFormat('MMMM yyyy', doc['intake'].toDate())).toString();
      // inTakes.add((dateTimeFormat('MMMM yyyy', doc['intake'].toDate())).toString());
      print('aaaaaaaaaaaaaaaaaaaa');
      // print(courses);
    }
  });
}

InputBorder errorOutlineInputBOrder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    width: 1,
    color: Colors.redAccent,
  ),
);
InputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    width: 1,
    color: Color(0xffBBC5CD),
  ),
);
List<String>expHeadList=[];
getExpenseHead()async{
  DocumentSnapshot expHead=await FirebaseFirestore.instance
      .collection('expenseHead')
      .doc('expenseHead')
      .get();
  print('///');
  List data=expHead['expenseHead'];
  for(dynamic  item in data) {
    expHeadList.add(item);
  }
  print(expHeadList);
  print('///');
}

Map<String , dynamic> UniversityNameToId ={};
Map<String , dynamic> UniversityIdToName ={};
List<String>universityList=[];
getUniversity(){
  FirebaseFirestore.instance.collection('university')
      .snapshots()
      .listen((event) {
    universityList.clear();
        for(var university in event.docs){
          universityList.add(university['name']);
          UniversityNameToId[university['name']]=university.id;
          UniversityIdToName[university.id]=university.get('name');
        }
        print(universityList);
  });
}

List<Item>tutorList=[];
List<String>tutorNameList=[];
Map<String,dynamic>tutorMap={};
Map<String,dynamic>tutorNameToId={};
Map<String,dynamic>tutorIdToName={};
getTutors() async {
  QuerySnapshot data1 =
  await FirebaseFirestore.instance
      .collection("tutor")
      .get();
  for (var tutor in data1.docs) {
    print(tutor.id+'dddddddddddd');
    tutorMap[tutor.id]=tutor.data();
    tutorNameToId[tutor.get('name')]=tutor.id;
    tutorIdToName[tutor.id]=tutor.get('name');
    tutorNameList.add(tutor['name']);
    print(tutor.get('name'));

    if(tutor['available']==true){
      tutorList.add(Item.build(
        value: tutor.id,
        display: tutor.get('name'),
        content: tutor.get('name').toString(),
      ));
    }

  }

}


List<String> dept=[];
getDepartments() async {
  DocumentSnapshot abc=await FirebaseFirestore.instance
      .collection('settings')
      .doc(currentbranchId)
      .get();
  List data=abc['department'];
  for(dynamic  item in data) {
    dept.add(item);
  }

  print(dept.length);
  print(dept);
}

Map<String,dynamic>countryMap={};
Map<String,dynamic>countryIdByName={};
bool currentUserPermission;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

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

  updateProduct(){
    List list =[
      {
        'name':'Personal Details',
        'completed':false,
      },
      {
        'name':'Travail & Immigration',
        'completed':false,
      },
      {
        'name':'Education',
        'completed':false,
      },
      {
        'name':'Referee Details',
        'completed':false,
      },
      {
        'name':'Work Details',
        'completed':false,
      },
      {
        'name':'Documents',
        'completed':false,
      },
      {
        'name':'Applications',
        'completed':false,
      },
      {
        'name':'ShortList & Apply',
        'completed':false,
      },
      {
        'name':'Messages',
        'completed':false,
      },
    ];
    
    FirebaseFirestore.instance.collection('branch').get().then((value) {
      for(DocumentSnapshot snap in value.docs){
        // FirebaseFirestore.instance.collection('testProduct').add(snap.data());
        FirebaseFirestore.instance.collection('settings').doc(snap.id).set({
          'studentId':0,
          'enquiryId':0,

        });
      }
    });
  }
  
  getUsers(){
    FirebaseFirestore.instance.collection('admin_users').snapshots().listen((event) {

      for(DocumentSnapshot doc in event.docs){

        currentUserMap[doc.id]=doc.data();
        currentUserIdToName[doc.id]=doc.get('display_name');
      }
      if(mounted){
        setState(() {

        });
      }

    });
  }





  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  void initState() {
    super.initState();
    // getIntake();
    print(currentbranchName+' ?????????????????????????????????????????????');
    getUsers();
    getSelectedCourse();
    getSelectedInTake();
    getUniversity();
    getBranches();
    getExpenseHead();
    getTutors();
    getClasses();
    getDepartments();
    print('************************************');


    _tabController = TabController(vsync: this, length: 21, initialIndex: 0);
    // updateProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: currentUserPermission==false?
      Center(child: Text('Please Contact Admin',style: TextStyle(fontSize: 20,color: Colors.black),),)
          : ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // if (sizingInformation.isDesktop) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenu(tabController: _tabController),
                //RETIFICAR AQUI
                Expanded(
                  child: TabBarView(
                       physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        HomeTab(),//0
                        AddTutor(),//1
                        AddEnquiryWidget(),//2
                        EnqyiryListWidget(),//3
                        FollowUpPage(),//4
                        StudentListWidget(),//5
                        NewSchedules(),//6
                        PaymentReport(),//Reports(),//7
                        CreateUsersWidget(),//8
                        AddCourseWidget(),//9
                        AddUniversity(),//10
                        AddIntakeWidget(),//11
                        AddClass(),//12
                        ExpensePage(),//13
                        AddExpense(),//14
                        AdmissionReport(),//15
                        AddDepartment(),//16
                        EnquiryReport(),//17
                        StudentRequest(),//18
                        RejectedStudents(),//19
                        AddBranchWidget()//20
                      ]),
                )
              ],

              //Outras Tabs
            );
          // }

          // if (sizingInformation.isMobile) {
          //   return Center(child: Text("Is Mobile"));
          // }
          // // if (sizingInformation.isTablet) {
          // //   return Text("Is Tablet :)");
          // // }
          //
          // return Text("Default");
        },
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
