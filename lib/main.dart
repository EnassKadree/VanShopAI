import 'package:flutter/material.dart';
import 'package:vanshopai/View/Auth/Other/entry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return Directionality
    (
      textDirection: TextDirection.rtl,
      child: MaterialApp
        (
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            fontFamily: 'Cairo',
            useMaterial3: true,
          ),
          localizationsDelegates: 
          const 
          [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales:   
          const [
            Locale('ar', ''),
          ],
          locale: const Locale('ar', ''), 
          home: const EntryPage(),
      ),
    );
  }
}
