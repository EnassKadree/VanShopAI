
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanshopai/Extensions/clipper.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) 
  {
    return Stack
    (
      children: 
      [
        ClipPath
        (
          clipper: MySecondCustomClipper(),
          child: Container
          (
            height: 200,
            color: Colors.orange[200]!.withOpacity(.5),
          ),
        ),
        ClipPath
        (
          clipper: MyFirstCustomClipper(),
          child: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors, // Colors similar to the image
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Center
        (
          child: Column
          (
            children: 
            [
              const SizedBox(height: 50,),
              Container
              (
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 252, 249, 245),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(logo, height: 130,fit: BoxFit.cover,), // Adjust logo size to fit design
              ),
            ],
          ),
        ),
      ],
    );
  }
}