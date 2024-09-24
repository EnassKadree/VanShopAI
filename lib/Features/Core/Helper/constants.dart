
//* variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vanshopai/Features/Products/Controller/Search%20Products/product_search_cubit.dart';
import 'package:vanshopai/Features/Representatives/Controller/Store%20Dists/store_dists_cubit.dart';

import '../../Auth/Controller/Categories Cubit/categories_cubit.dart';
import '../../Auth/Controller/Login Cubit/login_cubit.dart';
import '../../Auth/Controller/Signup Account Cubit/signup_account_cubit.dart';
import '../../Auth/Controller/Signup Cubit/sign_up_cubit.dart';
import '../../Auth/Controller/Subscription Plan Cubit/subscription_plan_cubit.dart';
import '../../Home/Controller/bottom_nav_cubit.dart';
import '../../Orders/Controller/Add Order Cubit/add_order_cubit.dart';
import '../../Orders/Controller/Generate PDF Cubit/generate_pdf_cubit.dart';
import '../../Orders/Controller/Get Order Details Cubit/get_order_details_cubit.dart';
import '../../Orders/Controller/Get Orders Cubit/get_orders_cubit.dart';
import '../../Orders/Controller/Quantity Cubit/quantity_cubit.dart';
import '../../Orders/Controller/Update Order/update_order_cubit.dart';
import '../../Products/Controller/Get Products Cubit/get_products_cubit.dart';
import '../../Products/Controller/Products Cubit/products_cubit.dart';
import '../../Representatives/Controller/Company Representatives/representatives_cubit.dart';
import '../../Stores/Controller/Add Store Cubit/add_store_cubit.dart';
import '../../Stores/Controller/Get Stores Cubit/get_stores_cubit.dart';

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
  BlocProvider(create: (context) => StoreDistsCubit()),
  BlocProvider(create: (context) => ProductSearchCubit()),
];
List<Map<String,dynamic>> appCountries = 
[
  {
    'country': '' ,
    'provinces':
    <String>[
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  },
  {
    'country': '' ,
    'provinces':
    <String>[
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  },
  {
    'country': '' ,
    'provinces':
    <String>[
      ' '
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      ' ',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  },
  {
    'country': '' ,
    'provinces':
    <String>[
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      ' ',
    ]
  },
  {
    'country': '' ,
    'provinces':
    <String>[
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  },
  {
    'country' :'',
    'provinces': <String>
    [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  },
  {
    'country' :'',
    'provinces': <String>
    [
      ' ',
      '',
      '',
      '',
      '',
      '',
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