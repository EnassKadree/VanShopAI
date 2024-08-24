
//* variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const image1 = 'Assets/Images/1.png';
const logo = 'Assets/Images/logo.png';

List<Color> gradientColors = [Colors.orange[300]!, Colors.orange[600]!, Colors.orange[700]!, Colors.orange[900]!];

//* user types
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