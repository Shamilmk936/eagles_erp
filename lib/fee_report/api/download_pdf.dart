//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:smile_erp/app/app_widget.dart';
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
var globIcon;
var logo;

var format = NumberFormat.simpleCurrency(locale: 'en_in');

class Pdf_Download{
  static Future<File> generate(StudentDetails invoice) async {
    final pdf = Document();

    image = await imageFromAssetBundle('assets/images/flit_logo1.png');
    locationIcon = await imageFromAssetBundle('assets/images/location-01.png');
    phoneIcon = await imageFromAssetBundle('assets/images/phone-01.png');
    mailIcon = await imageFromAssetBundle('assets/images/mail-01.png');
    globIcon = await imageFromAssetBundle('assets/images/glob_icon.png');
    logo = await imageFromAssetBundle('assets/images/logo1.png');

    pdf.addPage(MultiPage(
      margin: pw.EdgeInsets.zero,
      build: (context) => [

        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children:[
//START
              pw.Container(
                height: 30,
                width: double.infinity,
                color: PdfColor.fromInt(0xff421A60),
              ),

              pw.Container(
                height: 120,
                width: double.infinity,
                child:pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [

                     pw.Row(
                       mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                       children: [
                         pw.Container(

                           child:  pw.Image(logo,width: 100,height: 120,fit: pw.BoxFit.fill),
                         ),
                         pw.SizedBox(width: 10),
                         pw.Container(
                             height: 90,
                             width: 70,
                             child: pw.Center(child: pw.Text(currentbranchName,style: pw.TextStyle(color:PdfColors.black)))
                         ),
                       ]
                     ),

                      pw.Container(
                          height: 120,
                          width: 200,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.SizedBox(height: 5),
                              pw.Row(
                                  children:[
                                    pw.Container(
                                      height: 20,
                                      child: pw.Image(locationIcon,width: 20,height: 20,fit: pw.BoxFit.contain),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Container(
                                        height: 40,
                                        width: 180,
                                        child: pw.Text(currentbranchAddress,style:pw.TextStyle(fontSize: 13,color: PdfColors.black))
                                    )
                                  ]
                              ),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children:[
                                    pw.Container(
                                      height: 18,
                                      child: pw.Image(phoneIcon,width: 20,height: 18,fit: pw.BoxFit.contain),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Container(
                                        height: 18,
                                        width: 180,
                                        child: pw.Text(currentbranchphoneNumber,style:pw.TextStyle(fontSize: 13,color: PdfColors.black))
                                    )
                                  ]
                              ),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children:[
                                    pw.Container(
                                      height: 18,
                                      child: pw.Image(mailIcon,width: 20,height: 18,fit: pw.BoxFit.contain),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Container(
                                        height: 18,
                                        width: 180,
                                        child: pw.Text(currentbranchEmail,style:pw.TextStyle(fontSize: 13,color: PdfColors.black))
                                    )
                                  ]
                              ),
                            ]
                          )
                      )
                    ]
                ),
              ),

//STUDENT DETAIL
             pw.Padding(
               padding: pw.EdgeInsets.only(left: 50,right: 50,top: 30),
                 child:
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
                                     pw.Container(
                                         width: 70,
                                         child: pw.Row(
                                             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                             children: [
                                               pw.Text('Student ID',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                               pw.Text(':',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                             ]
                                         )),
                                     pw.Container(width: 170,child: pw.Text(' ${invoice.studentId}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   ]
                               ),
                               pw.SizedBox(height: 5),
                               pw.Row(
                                   children: [
                                     pw.Container(
                                         width: 70,
                                         child: pw.Row(
                                             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                             children: [
                                               pw.Text('Name',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                               pw.Text(':',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                             ]
                                         )),
                                     pw.Container(width: 170,child: pw.Text(' ${invoice.name}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   ]
                               ),
                               pw.SizedBox(height: 5),
                               pw.Row(
                                 mainAxisAlignment: pw.MainAxisAlignment.start,
                                   children: [
                                     pw.Container(
                                         width: 70,
                                         child: pw.Row(
                                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                       children: [
                                         pw.Text('Course',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                         pw.Text(':',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                       ]
                                     )),
                                     pw.Container(width: 170,child: pw.Text(' ${invoice.course}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   ]
                               ),
                               pw.SizedBox(height: 5),
                               pw.Row(
                                   children: [
                                     pw.Container(
                                         width: 70,
                                         child: pw.Row(
                                             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                             children: [
                                               pw.Text('Intake',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                               pw.Text(':',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                             ]
                                         )),
                                     pw.Container(width: 170,child: pw.Text(' ${invoice.intake}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                   ]
                               ),

                             ]
                         ),
                       ),

                       pw.Container(
                         width: 170,
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
             ),

              pw.SizedBox(height: 50),

//TABLE
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 50,right: 50),
              child: pw.Container(
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
            ),


              //last section

              pw.SizedBox(height: 30),

              pw.Padding(
                padding: pw.EdgeInsets.only(left: 50,right: 50),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(height: 10,width: 10),
                      pw.Container(
                          height: 100,
                          width: 200,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [

                                pw.Row(
                                    children: [
                                      pw.Container(width: 110,child: pw.Text('Total Fee',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.totalFee}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 110,child: pw.Text('Scholarship(-)',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.discount}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 110,child: pw.Text('Total Paid',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.feePaid}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ),
                                invoice.feeDue!=0&& invoice.dueDate!='' &&invoice.dueDate!=null?
                                pw.Row(
                                    children: [
                                      pw.Container(width: 110,child: pw.Text('Due Date',style: pw.TextStyle(fontSize: 11,)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.dueDate}',style: pw.TextStyle(fontSize: 11,)),),
                                    ]
                                ):
                                    // pw.Container(),
                                pw.Container(height: 5,child: pw.Text(':  ${invoice.dueDate}',style: pw.TextStyle(fontSize: 11,)),),
                                pw.Row(
                                    children: [
                                      pw.Container(width: 110,child: pw.Text('Balance Due',style: pw.TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),),
                                      pw.Container(width: 80,child: pw.Text(':  ${invoice.feeDue}',style: pw.TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),),
                                    ]
                                ),
                                pw.SizedBox(height: 5),

                              ]
                          )
                      ),
                    ]
                ),
              ),

              pw.Container(
                  height: 190,
              ),

            ]
        ),

//END
        pw.Container(
          height: 40,
          width: double.infinity,
          color: PdfColor.fromInt(0xff421A60),
          child:pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [

                pw.Container(
                    height: 40,
                    width: 120,
                    child: pw.Row(
                        children:[
                          pw.Image(globIcon,width: 20,height: 20,fit: pw.BoxFit.contain,),

                          pw.SizedBox(width: 3),
                          pw.Text('www.firstlogicinstitute.com',style:pw.TextStyle(fontSize: 13,color: PdfColors.white))
                        ]
                    )
                ),

              ]
          ),
        ),




      ],
    ));



    //WEB DOWNLOAD

    var  data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
    html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${invoice.studentId}.pdf';

    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //WEB OPEN
    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

    //ANDROID OPEN
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