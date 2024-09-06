  import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

String formatDate(DateTime? date) 
  {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
  
  double calculateTotalPrice(List<Map<String, dynamic>> orderProducts) 
  {
    return orderProducts.fold(0.0, (total, product) {
      return total + (product['price'] * product['quantity']);
    });
  }

  Future<pw.Font> loadFont() async
  {
    final fontData = await rootBundle.load('Assets/Fonts/Cairo-Bold.ttf');
    return pw.Font.ttf(fontData);
  }
