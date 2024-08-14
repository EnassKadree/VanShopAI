
import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder
{
  final Page;
  SlideRight({this.Page}): super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = const Offset(-1 , 0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      //var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    }
  );
}


class SlideLeft extends PageRouteBuilder
{
  final Page;
  SlideLeft ({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child)
    {
      var begin = const Offset(1, 0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      //var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    } 
  );
}

class SlideDown extends PageRouteBuilder
{
  final Page;
  SlideDown({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = const Offset(0 , -1);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      //var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    }
  );
}

class SlideUp extends PageRouteBuilder
{
  final Page;
  SlideUp({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = const Offset(0 , 1);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      // var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    }
  );
}

class SlideCross extends PageRouteBuilder
{
  final Page;
  SlideCross({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = const Offset(-1 , 1);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      //var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);    }
  );
}

class SlideCross2 extends PageRouteBuilder
{
  final Page;
  SlideCross2({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = const Offset(1 , -1);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      // var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return SlideTransition(position: tween.animate(curvedAnimation), child: child,);
    }
  );
}

class ScaleUp extends PageRouteBuilder
{
  final Page;
  ScaleUp({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = 0.0;
      var end = 1.0;
      var tween = Tween(begin: begin, end: end);
      // var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return ScaleTransition(scale: tween.animate(curvedAnimation), child: child,);
    }
  );
}

class Rotate extends PageRouteBuilder
{
  final Page;
  Rotate({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = 0.0;
      var end = 1.0;
      var tween = Tween(begin: begin, end: end);
      // var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return RotationTransition(turns: tween.animate(curvedAnimation), child: child,);
    }
  );
}

class SizeUp extends PageRouteBuilder
{
  final Page;
  SizeUp({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      return Align(alignment: Alignment.center, child: SizeTransition(sizeFactor: animation, child: child));
    }
  );
}

class Fade extends PageRouteBuilder
{
  final Page;
  Fade({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
    }
  );
}

class ScaleRotation extends PageRouteBuilder
{
  final Page;
  ScaleRotation({this.Page}) : super
  (
    pageBuilder: (context, animation, animationtwo) => Page,
    transitionsBuilder: (context, animation, animationtwo, child) 
    {
      var begin = 0.0;
      var end = 1.0;
      var tween = Tween(begin: begin, end: end);
      // var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
      return ScaleTransition
      (
        scale: tween.animate(curvedAnimation),
        child: RotationTransition(turns: tween.animate(curvedAnimation), child: child,),
      );
    }
  );
}
