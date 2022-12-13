//@dart=2.9



import '../../backend/backend.dart';

class StudentDetails {

  final String name;
  final String course;
  final double feePaid;
  final double feeDue;
  final String date;
  final String paymentMethod;
  final double totalFee;
  final double lastPaymentAmount;
  final double discount;
  final double totalFeeWithDiscount;
  final String studentId;
  final String intake;
  final String receiptNo;
  final String dueDate;


  const StudentDetails({
    this.name,
    this.course,
    this.feePaid,
    this.feeDue,
    this.date,
    this.paymentMethod,
    this.totalFee,
    this.lastPaymentAmount,
    this.discount,
    this.totalFeeWithDiscount,
    this.studentId,
    this.intake,
    this.receiptNo,
    this.dueDate,
  });
}


//STUDENT QR

class DownloadStudentQr {

  final String studentName;
  final String studentId;

  const DownloadStudentQr({
    this.studentName,
    this.studentId,

  });

}

//STAFF QR

class DownloadStaffQr {

  final String staffName;
  final String staffId;

  const DownloadStaffQr({
    this.staffName,
    this.staffId,

  });

}


