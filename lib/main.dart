import 'package:flutter/material.dart';
import 'package:vanshopai/View/entry.dart';
import 'package:vanshopai/View/singup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: const Directionality
      (
        textDirection: TextDirection.rtl,
        child: EntryPage()
      )
    );
  }
}
