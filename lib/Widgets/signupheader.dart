
import 'package:flutter/material.dart';
import 'package:vanshopai/Visuals/clipper.dart';
import 'package:vanshopai/constants.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath
    (
      clipper: MyCustomClipper(),
      child: Container
      (
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColors)),
        child: Column
        (
          children: 
          [
            const SizedBox(height: 24,),
            Image.asset(image1,height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text(
                  'VanShopAI',
                  style: TextStyle(
                      color: Colors.blue[900]!,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}