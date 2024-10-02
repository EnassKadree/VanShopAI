import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../../Extensions/sharedprefsutils.dart';
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
      String storeId = prefs.getString('userID')!;
      emit(ProductSearchLoading());

      QuerySnapshot distributorSnapshot = await fireStore
          .collection(distributorsConst)
          .where('stores', arrayContains: storeId)
          .get();

      QuerySnapshot representativeSnapshot = await fireStore
          .collection(representativeConst)
          .where('stores', arrayContains: storeId)
          .get();

      List<String> distributorIds = distributorSnapshot.docs.map((doc) => doc.id).toList();
      List<String> companyIds = representativeSnapshot.docs.map((doc) => doc['company_id'].toString()).toList();

      List<Product> products = [];

      if (distributorIds.isNotEmpty) 
      {
        QuerySnapshot productSnapshot = await fireStore
            .collection(productsConst)
            .where('archived', isEqualTo: false)
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff')
            .where('distributor_id', whereIn: distributorIds)
            .get();

        products.addAll(productSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)));
      }


      if (companyIds.isNotEmpty) 
      {
        QuerySnapshot companyProductSnapshot = await fireStore
            .collection(productsConst)
            .where('archived', isEqualTo: false)
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff')
            .where('company_id', whereIn: companyIds)
            .get();

        products.addAll(companyProductSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)));
      }


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
        } else if (product.companyId != null) 
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
    } catch (e) {
      emit(ProductSearchFailure(e.toString()));
    }
  }
}
