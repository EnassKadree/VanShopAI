import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/cubit/products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/customtextfield.dart';
import 'package:vanshopai/Widgets/progressindicator.dart';
import 'package:vanshopai/constants.dart';

import '../../sharedprefsUtils.dart';

class AddProductPage extends StatelessWidget 
{
  AddProductPage({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: BlocConsumer<ProductsCubit, ProductsState>
      (
        listener: (context, state) 
        {
          if(state is AddProductFailure)
          {
            ShowSnackBar(context, 'حصل خطأ ما! حاول مرة أخرى');
          }
          else if(state is AddProductSuccess)
          {
            ShowSnackBar(context, 'تمت إضافة المنتج بنجاح');
            pop(context);
          }
        },
        builder: (context, state) 
        {
          if(state is AddProductLoading)
          {
            return const MyProgressIndicator();
          }
          else
          {
            return ListView
            (
              children: 
              [
                Text(
                  'إضافة منتج جديد',
                  style: TextStyle
                  (
                    color: Colors.orange[700]!,
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 80,
                  child: Image.asset(productImage),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  hint: 'اسم المنتج',
                  controller: name,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hint: 'وصف المنتج',
                  controller: description,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hint: 'السعر',
                  controller: price,
                ),
                const SizedBox(
                  height: 42,
                ),
                CustomButton(
                  text: 'إضافة المنتج',
                  onTap: () 
                  {
                    Product product = Product
                    (
                      id: '',
                      name: name.text, 
                      description: description.text, 
                      price: double.parse(price.text),
                      companyId: prefs.getString('userID')
                    );
                    cubit.addProduct(product);
                  },
                )
              ],
            );
          }
        },
      ),
    ));
  }
}
