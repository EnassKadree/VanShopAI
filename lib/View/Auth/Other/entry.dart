import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Other/usertype.dart';
import 'package:vanshopai/Visuals/clipper.dart';
import 'package:vanshopai/constants.dart';

class EntryPage extends StatelessWidget 
{
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.orange[700]!,
      body: Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        children: 
        [
          ClipPath
          (
            clipper: MyCustomClipper(),
            child: Container
            (
              width: double.infinity,
              color: Colors.white,
              child: Column
              (
                children:
                [
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Text
                  (
                    'VanShopAI', 
                    style: TextStyle
                    (
                      fontSize: 65, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.orange[700]!,
                      shadows: const [Shadow(color: Colors.grey, blurRadius: 2, offset: Offset(0,0))],

                    ),
                  ),
                  const SizedBox(height: 16,),
                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(image1, height: 200,),
                  ),
                  //const SizedBox(height: 42,),
                  SizedBox(height: MediaQuery.of(context).size.height/7,),
                ]
              ),
            ),
          ),
          const Spacer(),
          const Text('Order', style: TextStyle(fontSize: 45, color: Colors.white),),
          const Text('عالبكلة', style: TextStyle(fontSize: 40, color: Colors.white),),
          const Spacer(flex: 2,),
          Padding
          (
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector
            (
              onTap: () 
              {
                navigateReplace(context, const CheckUserType());
              },
              child: const Row
              (
                mainAxisAlignment: MainAxisAlignment.end,
                children: 
                [
                  Text('دخول', style: TextStyle(fontSize: 25, color: Colors.white),),
                  Icon(Iconsax.arrow_left_2, color: Colors.white,size: 35,),
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}