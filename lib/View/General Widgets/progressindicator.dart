import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget 
{
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Center(child: CircularProgressIndicator(color: Colors.orange[700]!,),);
  }
}