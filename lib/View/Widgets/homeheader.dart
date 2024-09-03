import 'package:flutter/material.dart';
import 'package:vanshopai/Visuals/clipper.dart';
import 'package:vanshopai/constants.dart';

import '../../sharedprefsUtils.dart';


class HomeHeader extends StatelessWidget 
{
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return ClipPath
    (
      clipper: MyCustomClipper(),
      child: Container
      (
        width: double.infinity,
        height: MediaQuery.of(context).size.height/5,
        decoration: BoxDecoration
        (
          gradient: LinearGradient
          (
            colors: gradientColors
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            [
              const Text('أهلاً بك!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
              Row
              (
                children: 
                [
                  const Spacer(),
                  Text(prefs.getString('name').toString(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}