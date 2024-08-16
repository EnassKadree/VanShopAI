// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanshopai/Widgets/radioListView.dart';
import 'package:vanshopai/Widgets/custombutton.dart';

class CheckCompanyCategory extends StatefulWidget 
{
  const CheckCompanyCategory({super.key});

  @override
  State<CheckCompanyCategory> createState() => _CheckCompanyCategoryState();
}

class _CheckCompanyCategoryState extends State<CheckCompanyCategory> {
  int selectedValue = 0;

  List<String> items = 
  [
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
    'فئة معينة',
  ];

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Text('ما هي منتجات شركتك؟',
            style: TextStyle(color: Colors.orange[700]!, fontSize: 32, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            RadioListView(items: items, selectedValue: selectedValue),
            CustomButton(text: 'تم')
          ],
        ),
      )
    );
  }
}