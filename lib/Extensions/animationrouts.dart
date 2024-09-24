
import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder
{
  final page;
  SlideRight({this.page}): super
  (
    pageBuilder: (context, animation, animationTow) => page,
    transitionsBuilder: (context, animation, animationTow, child) 
    {
      var begin = const Offset(-1 , 0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);

      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.linear);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    }
  );
}