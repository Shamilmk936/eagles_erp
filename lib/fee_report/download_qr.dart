// //@dart=2.9
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:smile_erp/app/app_widget.dart';
// import 'package:smile_erp/fee_report/api/pdf_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:printing/printing.dart';
//
// import '../app/tabs/Student/StudentSinglePageView.dart';
// import 'api/Invoice.dart';
//
//
//
// var format = NumberFormat.simpleCurrency(locale: 'en_in');
//
// class QRDownloadApi {
//   static Future<File> generate(DownloadStudentQr qr) async {
//     final pdf = Document();
//
//     pdf.addPage(MultiPage(
//       build: (context) =>
//       [
//
//         pw.SizedBox(height: 50),
//
//         pw.Container(
//             child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 mainAxisAlignment: pw.MainAxisAlignment.start,
//                 children: [
//
//                   pw.SizedBox(height: 50),
//                   pw.Text(qr.studentId, style: pw.TextStyle(fontSize: 15,)),
//                   pw.Text(qr.studentName, style: pw.TextStyle(fontSize: 15,)),
//                   pw.SizedBox(height: 30),
//
//                   pw.Image(pw.MemoryImage(qrImage),
//                       width: 150,
//                       height: 150,
//                       fit: pw.BoxFit.fill),
//
//
//
//                 ]
//             )
//         ),
//
//       ],
//     ));
//
//     print('aaaaaaaaaaaaaaaaaaaaaa');
//
//     //web
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdf.save());
//     print('bbbbbbbbbbbbbbbbbbbbbbbb');
//
//     //android
//     // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
//   }
//
//
// }
