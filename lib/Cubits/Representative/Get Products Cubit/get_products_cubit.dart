import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Model/product.dart';

import '../../../constants.dart';
import '../../../sharedprefsUtils.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> 
{
  GetProductsCubit() : super(GetProductsInitial());
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> products = [];


    Future<void> getProducts() async
    {
      emit(GetProductsLoading());
      try
      {
        QuerySnapshot querySnapshot = await firestore.collection(productsConst)
        .where('company_id', isEqualTo: prefs.getString('companyID')).where('archived', isEqualTo: false)
        .get();

        products = querySnapshot.docs.map((doc) 
        {
          return Product.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
      }).toList();

      emit(GetProductsSuccess());

    }catch(e)
    {
      emit(GetProductsFailure(e.toString()));
    }
  }

  String getProductNameById(String productId) 
  {
    final product = products.firstWhere((prod) => prod.id == productId);
    return product.name;
  }

  double getProductPriceById(String productId) 
  {
    final product = products.firstWhere((prod) => prod.id == productId);
    return product.price;
  }
}
