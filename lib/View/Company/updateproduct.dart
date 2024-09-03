import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/View/General%20Widgets/custombutton.dart';
import 'package:vanshopai/View/General%20Widgets/customtextfield.dart';
import 'package:vanshopai/View/General%20Widgets/progressindicator.dart';
import 'package:vanshopai/constants.dart';


class UpdateProductPage extends StatelessWidget 
{
  UpdateProductPage({super.key, required this.product});
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    name.text = product.name;
    description.text = product.description;
    price.text = product.price.toString();
    return Scaffold
    (
      body: Padding
      (
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: BlocConsumer<ProductsCubit, ProductsState>
      (
        listener: (context, state) 
        {
          if(state is UpdateProductFailure)
          {
            ShowSnackBar(context, 'حصل خطأ ما! حاول مرة أخرى');
          }
          else if(state is UpdateProductSuccess)
          {
            ShowSnackBar(context, 'تم تعديل معلومات المنتج بنجاح');
            pop(context);
          }
        },
        builder: (context, state) 
        {
          if(state is UpdateProductLoading)
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
                  Text(
                    'تعديل المنتج',
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

                  GestureDetector
                  (
                    onTap: (){cubit.imageChanged = true; cubit.pickImage();},
                    child: CircleAvatar
                    (
                      backgroundColor: Colors.grey[200],
                      radius: 80,
                      child: 
                      cubit.selectedImage != null? 
                        ClipOval
                        (
                          child: Image.file
                          (
                            cubit.selectedImage!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover, 
                          ),
                        )
                      : product.image != null?
                        ClipOval
                        (
                          child: Image.network
                          (
                            product.image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover, 
                          ),
                        )
                      :
                        Image.asset
                        (
                          productImage,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
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
                    text: 'تعديل المنتج',
                    onTap: () 
                    {
                      if(formKey.currentState!.validate())
                      {
                        Product newProduct = Product
                        (
                          id: product.id,
                          name: name.text, 
                          description: description.text, 
                          price: double.parse(price.text),
                          companyId: product.companyId,
                          archived: product.archived,
                          image: product.image
                        );
                      cubit.updateProduct(newProduct);
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