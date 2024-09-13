import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Products/Controller/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';
import 'package:vanshopai/Features/Core/Model/product.dart';
import 'package:vanshopai/Features/Orders/View/Components/custombutton.dart';
import 'package:vanshopai/Components/customtextfield.dart';
import 'package:vanshopai/Components/progressindicator.dart';


class UpdateProductPage extends StatelessWidget 
{
  const UpdateProductPage({super.key, required this.product, required this.sender});
  final Product product;
  final String sender;

  @override
  Widget build(BuildContext context) 
  {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController name = TextEditingController();
    final TextEditingController description = TextEditingController();
    final TextEditingController price = TextEditingController();

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
            if(product.archived)
            {
              cubit.getProducts(archived: true, sender: sender);
            }
            else
            {
              cubit.getProducts(archived: false, sender: sender);
            }
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
                        SizedBox
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
                          distributorId: product.distributorId,
                          archived: product.archived,
                          image: product.image
                        );
                      cubit.updateProduct(newProduct, sender);
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