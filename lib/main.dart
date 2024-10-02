import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Auth/View/Other/authhome.dart';
import 'package:vanshopai/Features/Auth/View/Other/entry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Extensions/sharedprefsutils.dart';
import 'firebase_options.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initSharedPreferences();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return MultiBlocProvider
    (
      providers: providersConst,
      
      child: Directionality
      (
        textDirection: TextDirection.rtl,
        child: MaterialApp
        (
          debugShowCheckedModeBanner: false,
          theme: ThemeData
          (
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            fontFamily: 'Cairo',
            useMaterial3: true,
            bottomNavigationBarTheme: BottomNavigationBarThemeData
            (
              selectedItemColor: Colors.orangeAccent,  
              unselectedItemColor: Colors.brown[300], 
              showUnselectedLabels: true
            ),
          ),
          localizationsDelegates: const 
          [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [ Locale('ar', ''), ],
          locale: const Locale('ar', ''),

          home: 
          prefs.getString('userID') != null ? 
            getHomePage(prefs.getString('userType')!)
          : prefs.getBool('signedUp')?? false ?
            const AuthHomePage()
          :
            const EntryPage()
        ),
      ),
    );
  }
}