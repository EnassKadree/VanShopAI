
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanshopai/Extensions/clipper.dart';
import 'package:vanshopai/Helper/constants.dart';

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
            Container
            (
              decoration: const BoxDecoration
              (
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1)]
              ),
              child: Image.asset(logo,height: 120,)
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text(
                  'VanShopAI',
                  style: TextStyle
                  (
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [Shadow(color: Colors.black54,blurRadius: 1)]
                  ),
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