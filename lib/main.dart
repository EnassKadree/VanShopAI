import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Categories%20Cubit/categories_cubit.dart';
import 'package:vanshopai/Cubits/Auth/Login%20Cubit/login_cubit.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Account%20Cubit/signup_account_cubit.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Cubit/sign_up_cubit.dart';
import 'package:vanshopai/Cubits/Auth/Subscription%20Plan%20Cubit/subscription_plan_cubit.dart';
import 'package:vanshopai/Cubits/Company/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Cubits/Company/Represntatives%20Cubit/representatives_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Add%20Order%20Cubit/add_order_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Quantity%20Cubit/quantity_cubit.dart';
import 'package:vanshopai/View/Auth/Other/entry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vanshopai/sharedprefsUtils.dart';
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
      providers: 
      [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpAccountCubit()),
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(create: (context) => PlanCubit()),
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(create: (context) => RepresentativesCubit()),
        BlocProvider(create: (context) => AddOrderCubit()),
        BlocProvider(create: (context) => GetStoresCubit()),
        BlocProvider(create: (context) => GetProductsCubit()),
        BlocProvider(create: (context) => QuantityCubit()),
      ],
      child: Directionality
      (
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            fontFamily: 'Cairo',
            useMaterial3: true,
          ),
          localizationsDelegates: const 
          [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const 
          [
            Locale('ar', ''),
          ],
          locale: const Locale('ar', ''),
          home: 
          prefs.getString('userID') != null ? 
            getHomePage(prefs.getString('userType')!)
          :
            const EntryPage()
          // : prefs.getString('userData') == null?

        ),
      ),
    );
  }
}