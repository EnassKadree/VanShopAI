import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../Core/Helper/orderfunctions.dart';
import '../../../Core/Model/order.dart';


part 'generate_pdf_state.dart';

class GeneratePdfCubit extends Cubit<GeneratePdfState> 
{
  GeneratePdfCubit() : super(GeneratePdfInitial());

  Future<void> shareOrder(OrderModel order) async 
  {
    emit(GeneratePDFLoading());
    final pdfData = await generateOrderPdf(order);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/order_${order.id}.pdf');
    await file.writeAsBytes(pdfData);
    
    if(await file.exists())
    {
      await FlutterShare.shareFile
      (
        title: 'مشاركة الطلب',
        filePath: file.path,
        fileType: 'application/pdf',
      );
      emit(GeneratePDFSuccess());
    }
    else
    {
      emit(GeneratePDFFailure());
    }
  }

  
  Future<Uint8List> generateOrderPdf(OrderModel order) async 
  {

    final ttf = await loadFont();

    final pdf = pw.Document();

    pdf.addPage
    (
      pw.Page
      (
        build: (pw.Context context) 
        {
          return pw.Column
          (
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: 
            [
              pw.Text
              (
                'تفاصيل الطلب',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold,font: ttf, color: PdfColor.fromHex('#FFA07A'),),
                textDirection: pw.TextDirection.rtl
              ),
              pw.SizedBox(height: 16),
              pw.Row
              (
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: 
                [
                  pw.Text
                  (order.storeName, style: pw.TextStyle(fontSize: 20,font: ttf, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                  pw.Text
                  ('متجر:   ', style: pw.TextStyle(fontSize: 20,font: ttf, color: PdfColor.fromHex('#FFA07A')),textDirection: pw.TextDirection.rtl),
                ]
              ),

              pw.Row
              (
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: 
                [
                  pw.Text(formatDate(order.createdAt), style: pw.TextStyle(fontSize: 18,font: ttf, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                  pw.Text('تاريخ الطلب:   ', style: pw.TextStyle(fontSize: 18,font: ttf, color: PdfColor.fromHex('#FFA07A')),textDirection: pw.TextDirection.rtl),
                ]
              ),

              pw.SizedBox(height: 16),
              pw.Text('المنتجات المطلوبة:', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold,font: ttf, color: PdfColor.fromHex('#FFA07A')),textDirection: pw.TextDirection.rtl),
              pw.Row
              (
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: 
                [
                  pw.Text('السعر للقطعة', style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                  pw.SizedBox(width: 54),
                  pw.Text('العدد', style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                  pw.Spacer(flex: 2),
                  pw.Text('المنتج', style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                ],
              ),
              pw.Divider(),
              pw.ListView.builder
              (
                itemCount: order.products.length,
                itemBuilder: (context, index) 
                {
                  final product = order.products[index];
                  return pw.Column
                  (
                    children: 
                    [
                      pw.Row
                      (
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: 
                        [
                          pw.Text(product['price'].toString(), style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#808080')),textDirection: pw.TextDirection.rtl),
                          pw.Spacer(),
                          pw.Text(product['quantity'].toString(), style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#808080')),textDirection: pw.TextDirection.rtl),
                          pw.Spacer(flex: 2),
                          pw.Text(product['name'], style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColor.fromHex('#212931')),textDirection: pw.TextDirection.rtl),
                        ],
                    ),
                    pw.Divider()
                    ]
                  );
                },
              ),
              pw.SizedBox(height: 16),
              pw.Row
              (
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: 
                [
                  pw.Text
                  (calculateTotalPrice(order.products).toString(),
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold,font: ttf, color: PdfColor.fromHex('#8B4513')),textDirection: pw.TextDirection.rtl),
                  pw.Text
                  ('إجمالي:    ',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold,font: ttf, color: PdfColor.fromHex('#FFA07A')),textDirection: pw.TextDirection.rtl),
                ]
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
