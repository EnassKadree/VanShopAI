import 'package:flutter/material.dart';
import 'package:vanshopai/Model/Representative.dart';
import 'package:vanshopai/View/Widgets/representativeinfocard.dart';

class RepresentativeInfo extends StatelessWidget 
{
  const RepresentativeInfo({super.key, required this.rep});
  final Representative rep;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: ListView
        (
          children: 
          [
            Center(child: Text(rep.tradeName, style: TextStyle(color: Colors.orange[600], fontSize: 50),)),
            const SizedBox(height: 6,),
            RepresentativeInfoCard(data: rep.email!, type: 'email'),
            RepresentativeInfoCard(data: rep.phone!, type: 'phone'),
            RepresentativeInfoCard(data: rep.country, type: 'country'),
            RepresentativeInfoCard(data: rep.province, type: 'province'),
          ],
        ),
      ),
    );
  }
}