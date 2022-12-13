//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:smile_erp/app/app_widget.dart';
import 'package:smile_erp/fee_report/api/pdf_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'Invoice.dart';
import 'package:universal_html/html.dart' as html;

var image;
var locationIcon;
var phoneIcon;
var mailIcon;

var format = NumberFormat.simpleCurrency(locale: 'en_in');

class B2bPdfInvoiceApi {
  static Future<File> generate(StudentDetails invoice) async {
    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/flit_logo1.png');
    locationIcon = await imageFromAssetBundle('assets/images/location-01.png');
    phoneIcon = await imageFromAssetBundle('assets/images/phone-01.png');
    mailIcon = await imageFromAssetBundle('assets/images/mail-01.png');
    pdf.addPage(MultiPage(
      build: (context) => [

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children:[
//START
                pw.Container(
                  height: 100,
                  width: 700,
                ),
//STUDENT DETAIL
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [

                      pw.Container(
                        width: 250,
                        // color: PdfColors.green,
                        child:  pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [

                              pw.SizedBox(height: 20),
                              pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Student ID',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': ${invoice.studentId}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Name',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': ${invoice.name}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                  children: [
                                    pw.Container(width: 70,child: pw.Text('Course',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    pw.Container(width: 170,child: pw.Text(': ${invoice.course}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  ]
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                  children: [
                                    pw.Container(width: 70,child: pw.Text('Intake',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    pw.Container(width: 170,child: pw.Text(': ${invoice.intake}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  ]
                              ),

                            ]
                        ),
                      ),

                      pw.Container(
                        width: 170,
                        // color: PdfColors.green,
                        child:  pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [

                              pw.SizedBox(height: 20),
                              pw.Row(
                                  children: [
                                    pw.Container(width: 100,child: pw.Text('Rept.No',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    pw.Container(width: 70,child: pw.Text(': ${invoice.receiptNo}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  ]
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                  children: [
                                    pw.Container(width: 100,child: pw.Text('Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    pw.Container(width: 70,child: pw.Text(': ${invoice.date}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  ]
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                  children: [
                                    pw.Container(width: 100,child: pw.Text('Payment Mode',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    pw.Container(width: 70,child: pw.Text(': ${invoice.paymentMethod}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  ]
                              ),

                            ]
                        ),
                      ),

                ]
                ),

                pw.SizedBox(height: 50),

//TABLE
                pw.Container(
                  child:

                      pw.Table(
                          tableWidth: TableWidth.max,
                          border: pw.TableBorder.all(width: 1,color: PdfColors.grey),
                          children: [

                            pw.TableRow(
                                children: [
                                  pw.Container(width: 40,child:pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Sl.No',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))))),
                                  pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Description',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))))),
                                  pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Amount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))))),

                                ]
                            ),

                            pw.TableRow(
                                children: [
                                  pw.Container(height:90,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('1.'))),
                                  pw.Container(height:90,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Course Fee'))),
                                  pw.Container(height:90,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.lastPaymentAmount.toString()))),
                                ]
                            ),
                            pw.TableRow(
                                children: [
                                  pw.SizedBox(height:30,width: 40,),
                                  pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('SubTotal'))),
                                  pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.lastPaymentAmount.toString()))),
                                ]
                            ),
                          ]
                      ),


                ),

                //last section

                pw.SizedBox(height: 30),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(height: 10,width: 10),
                      pw.Container(
                          height: 100,
                          width: 160,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                              children: [

                                pw.Row(
                                    children: [
                                      pw.Container(width: 90,child: pw.Text('Total Fee',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.totalFee}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 90,child: pw.Text('Scholarship(-)',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.discount}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 90,child: pw.Text('Total Paid',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.feePaid}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                invoice.feeDue!=0&& invoice.dueDate!='' &&invoice.dueDate!=null?
                                pw.Row(
                                    children: [
                                      pw.Container(width: 90,child: pw.Text('Due Date',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.dueDate}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ):
                                    pw.Container(height: 1,),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 90,child: pw.Text('Balance Due',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.feeDue}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                    ]
                                ),
                                pw.SizedBox(height: 5),

                              ]
                          )
                      ),
                    ]
                ),

                 pw.Container(
                   height: 100
                 ),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('seal',style: pw.TextStyle(fontSize: 11,)),
                    pw.Container(width: 120,child: pw.Text('Official Signature',style: pw.TextStyle(fontSize: 11,)),)
                  ]
                ),
                pw.SizedBox(height: 30),

              ]
            ),

//END
        pw.Container(
          height: 50,
          width: 700,

        ),

      ],
    ));



    //web
    // final bytes = pdf.save();
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(
    //     await generate());
    // final anchor =
    // html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

     await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }





//
//   static buildText({
//      String title,
//      String value,
//     double width = double.infinity,
//     pw.TextStyle  titleStyle,
//     bool unite = false,
//   }) {
//      final style = titleStyle ?? pw.TextStyle(fontWeight: FontWeight.bold, );
//
//     return pw.Container(
//       width: width,
//       child: pw.Row(
//         children: [
//           pw.Expanded(child: pw.Text(title, style: style)),
//           pw.Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
 }