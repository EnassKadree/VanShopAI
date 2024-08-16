import 'package:flutter/material.dart';
import 'package:vanshopai/Visuals/clipper.dart';
import 'package:vanshopai/Widgets/usertypecard.dart';
import 'package:vanshopai/constants.dart';

class CheckUserType extends StatelessWidget 
{
  const CheckUserType({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Column(
        children: 
        [
          ClipPath
          (
            clipper: MyCustomClipper(),
            child: Container
            (
              width: double.infinity,
              height: MediaQuery.of(context).size.height/4,
              //color: Colors.orange,
              decoration: BoxDecoration
              (
                gradient: LinearGradient
                (
                  colors: gradientColors
                )
              ),
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text('أهلاً بك!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
                    Row
                    (
                      children: 
                      [
                        Spacer(),
                        Text('ما هو عملك؟', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          const UserTypeCard(text: 'شركة أو مؤسسة تجارية',),
          const UserTypeCard(text: 'مندوب شركة',),
          const UserTypeCard(text: 'موزع حر'),
          const UserTypeCard(text: 'صاحب متجر',),
          const Spacer(flex: 2,),
        ],
      ),
    );
  }
}
