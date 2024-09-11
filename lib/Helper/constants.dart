
//* variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../Features/Auth/Controller/Categories Cubit/categories_cubit.dart';
import '../Features/Auth/Controller/Login Cubit/login_cubit.dart';
import '../Features/Auth/Controller/Signup Account Cubit/signup_account_cubit.dart';
import '../Features/Auth/Controller/Signup Cubit/sign_up_cubit.dart';
import '../Features/Auth/Controller/Subscription Plan Cubit/subscription_plan_cubit.dart';
import '../Features/Home/Controller/bottom_nav_cubit.dart';
import '../Features/Oders/Controller/Add Order Cubit/add_order_cubit.dart';
import '../Features/Oders/Controller/Generate PDF Cubit/generate_pdf_cubit.dart';
import '../Features/Oders/Controller/Get Order Details Cubit/get_order_details_cubit.dart';
import '../Features/Oders/Controller/Get Orders Cubit/get_orders_cubit.dart';
import '../Features/Oders/Controller/Quantity Cubit/quantity_cubit.dart';
import '../Features/Oders/Controller/Update Order/update_order_cubit.dart';
import '../Features/Products/Controller/Get Products Cubit/get_products_cubit.dart';
import '../Features/Products/Controller/Products Cubit/products_cubit.dart';
import '../Features/Representatives/Controller/representatives_cubit.dart';
import '../Features/Stores/Controller/Add Store Cubit/add_store_cubit.dart';
import '../Features/Stores/Controller/Get Stores Cubit/get_stores_cubit.dart';

const image1 = 'Assets/Images/1.png';
const logo = 'Assets/Images/logo.png';

List<Color> gradientColors = [Colors.orange[300]!, Colors.orange[600]!, Colors.orange[700]!, Colors.orange[900]!];

//* strings
const companiesConst = 'Companies';
const distributorsConst = 'Distributors';
const storesConst = 'Stores';
const representativeConst = 'Representatives';
const countriesConst = 'Countries';
const provincesConst = 'provinces';
const categoriesConst = 'Categories';
const representativesNumberConst = 'number_of_representatives';
const plansConst = 'subscription_plan';
const productsConst = 'Products';
const ordersConst = 'Orders';

final List<SingleChildWidget> providersConst = 
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
  BlocProvider(create: (context) => GetOrdersCubit()),
  BlocProvider(create: (context) => GetOrderDetailsCubit()),
  BlocProvider(create: (context) => GeneratePdfCubit()),
  BlocProvider(create: (context) => UpdateOrderCubit()),
  BlocProvider(create: (context) => AddStoreCubit()),
  BlocProvider(create: (context) => BottomNavCubit()),
];
List<Map<String,dynamic>> appCountries = 
[
  {
    'country': 'سوريا' ,
    'provinces':
    <String>[
      'دمشق',
      'ريف دمشق',
      'حلب',
      'حمص',
      'اللاذقية',
      'دير الزور',
      'حماة',
      'درعا',
      'السويداء',
      'الرقة',
      'إدلب',
      'القنيطرة',
      'الحسكة',
    ]
  },
  {
    'country': 'لبنان' ,
    'provinces':
    <String>[
      'بيروت',
      'الشمال',
      'البقاع',
      'الجبل',
      'الجنوب',
      'المتن',
    ]
  },
  {
    'country': 'الجزائر' ,
    'provinces':
    <String>[
      'الجزائر العاصمة'
      'وهران',
      'قسنطينة',
      'عنابة',
      'بشار',
      'تمنراست',
      'بسكرة',
      'المدية',
      'تيزي وزو',
      'سيدي بلعباس',
      'البرج',
      'البليدة',
      'جيجل',
      'الشلف',
      'الطارف',
      'النعامة',
      'عين الدفلى',
      'ميلة',
      'بجاية',
      'مستغانم',
      'تيارت',
      'تلمسان',
      'سوق أهراس',
      'الواد',
    ]
  },
  {
    'country': 'البحرين' ,
    'provinces':
    <String>[
      'المنامة',
      'المحرق',
      'الرفاع',
      'سترة',
      'المهلب',
      'عوالي',
      'جزر حوار',
      'جزر أمواج',
    ]
  },
  {
    'country': 'مصر' ,
    'provinces':
    <String>[
      'القاهرة',
      'الإسكندرية',
      'الجيزة',
      'بورسعيد',
      'السويس',
      'الشرقية',
      'المنوفية',
      'الدقهلية',
      'الغربية',
      'الفيوم',
      'بني سويف',
      'المنيا',
      'أسيوط',
      'سوهاج',
      'قنا',
      'الأقصر',
      'أسوان',
      'مطروح',
      'الوادي الجديد',
      'دمياط',
      'البحيرة',
      'كفر الشيخ',
      'شمال سيناء',
      'جنوب سيناء',
    ]
  },
  {
    'country' :'العراق',
    'provinces': <String>
    [
      'بغداد',
      'البصرة',
      'الموصل',
      'كربلاء',
      'النجف',
      'السليمانية',
      'أربيل',
      'ديالى',
      'واسط',
      'بابل',
      'الديوانية',
      'كركوك',
      'صلاح الدين',
      'ذي قار',
      'المثنى',
    ]
  },
  {
    'country' :'الكويت',
    'provinces': <String>
    [
      'الكويت العاصمة',
      'حولي',
      'الأحمدي',
      'الجهراء',
      'مبارك الكبير',
      'الفروانية',
    ]
  }
];

addCountries()
{
  
  try
  {
    for(var country in appCountries)
    {
      FirebaseFirestore.instance.collection('Countries').add(country);
    }
    print('&&&&&&&&&&&&&&&&&&&&' 'added successfully');
  }
  catch(e)
  {
    print('&&&&&&&&&&&&&&&&&&&&$e');
  }
}