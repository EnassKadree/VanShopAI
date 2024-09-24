import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../Core/Model/product.dart';

part 'product_search_state.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> 
{
  ProductSearchCubit() : super(ProductSearchInitial());

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> searchProductsByName(String query) async 
  {
    try 
    {
      emit(ProductSearchLoading());

      QuerySnapshot productSnapshot = await fireStore
        .collection(productsConst)
        .where('archived' , isEqualTo: false)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

      List<Product> products = productSnapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

      List<String> owners = [];
      for (var product in products) 
      {
        String ownerName = '';
        
        if (product.distributorId != null) 
        {
          DocumentSnapshot distributor = await fireStore
            .collection(distributorsConst)
            .doc(product.distributorId)
            .get();
          ownerName = distributor['trade_name'];
        } 
        else if (product.companyId != null) 
        {
          DocumentSnapshot company = await fireStore
              .collection(companiesConst)
              .doc(product.companyId)
              .get();
          ownerName = company['trade_name'];
        }
        owners.add(ownerName);
      }

      emit(ProductSearchSuccess(products, owners));
    } catch (e) 
    {
      emit(ProductSearchFailure(e.toString()));
    }
  }

}
