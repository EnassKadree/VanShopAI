import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Products/Controller/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Core/Model/product.dart';
import 'package:vanshopai/Features/Orders/View/Components/custombutton.dart';
import 'package:vanshopai/Components/customtextfield.dart';
import 'package:vanshopai/Components/progressindicator.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../../Extensions/sharedprefsUtils.dart';


class AddDistProductPage extends StatelessWidget 
{
  const AddDistProductPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController name = TextEditingController();
    final TextEditingController description = TextEditingController();
    final TextEditingController price = TextEditingController();
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    return Scaffold
    (
      body: Padding
      (
      padding: const EdgeInsets.all(16),
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
            cubit.getProducts(archived: false, sender: distributorsConst);
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
            return Form
            (
              key: formKey,
              child: ListView
              (
                children: 
                [
                  TitleText(
                    'إضافة منتج جديد',
                    fontSize: 32
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  GestureDetector
                  (
                    onTap: cubit.pickImage,
                    child: CircleAvatar
                    (
                      backgroundColor: Colors.grey[200],
                      radius: 80,
                      child:cubit.selectedImage != null
                        ? ClipOval
                        (
                          child: Image.file
                          (
                            cubit.selectedImage!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover, 
                          ),
                        )
                        : SizedBox
                        (
                          height: 160,
                          width: 160,
                          child: Icon(Iconsax.gallery, size: 100,color: Colors.brown[300],)
                        )
                      ),
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
                      if(formKey.currentState!.validate())
                      {
                        Product product = Product
                        (
                          id: '',
                          name: name.text, 
                          description: description.text, 
                          price: double.parse(price.text),
                          distributorId: prefs.getString('userID')
                        );
                        cubit.addProduct(product, companiesConst);
                        formKey.currentState!.reset();
                      }
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
