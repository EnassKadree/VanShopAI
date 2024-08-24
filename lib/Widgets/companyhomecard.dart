
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Company/companyproducts.dart';

class CompanyHomeCard extends StatelessWidget 
{
  const CompanyHomeCard({
    super.key, required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell
    (
      onTap: ()
      {
        if (text == 'منتجات الشركة') {
          navigateTo(context, const CompanyProducts());
        }
      },
      child: Card
      (
        color: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Container
        (
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal:  24.0, vertical: 32),
          child: Center
          (
            child: Text
            (text, style:  const TextStyle(fontSize: 24,color: Colors.black54),),
          ),
        ),
      ),
    );
  }
}