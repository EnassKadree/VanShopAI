import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Model/product.dart';

import '../../../../Helper/constants.dart';
import '../../../../Extensions/sharedprefsUtils.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> 
{
  GetProductsCubit() : super(GetProductsInitial());
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> products = [];


    Future<void> getProducts(String sender) async
    {
      emit(GetProductsLoading());
      try
      {
        String owner = sender == representativeConst? 'company_id' : 'distributor_id';
        String ownerId = sender == representativeConst? prefs.getString('companyID')! : prefs.getString('userID')!;
        
        QuerySnapshot querySnapshot = await firestore.collection(productsConst)
        .where(owner, isEqualTo: ownerId)
        .where('archived', isEqualTo: false)
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
