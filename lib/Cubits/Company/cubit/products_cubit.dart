import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/constants.dart';
import 'package:vanshopai/sharedprefsUtils.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> 
{
  ProductsCubit() : super(ProductsInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Product> products = [];
  List<Product> archivedProducts = [];


  Future<void> getProducts() async
  {
    emit(ProductsLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(productsConst)
        .where('company_id', isEqualTo: prefs.getString('userID')).where('archived', isEqualTo: false)
        //.orderBy('name')
        .get();
      
      products = querySnapshot.docs.map((doc) 
      {
        return Product.fromJson
        ({
          ...doc.data() as Map<String, dynamic>, 
          'id': doc.id, 
        });
    }).toList();

      emit(ProductsSuccess(products));
    } catch (e) 
    {
      emit(ProductsFailure(e.toString()));
    }
  }

  Future<void> getArchivedProducts() async
  {
    emit(ProductsLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(productsConst)
        .where('company_id', isEqualTo: prefs.getString('userID')).where('archived', isEqualTo: true)
        //.orderBy('name')
        .get();
      
      archivedProducts = querySnapshot.docs.map((doc) 
      {
        return Product.fromJson
        ({
          ...doc.data() as Map<String, dynamic>, 
          'id': doc.id, 
        });
    }).toList();

      emit(ProductsSuccess(products));
    } catch (e) 
    {
      emit(ProductsFailure(e.toString()));
    }
  }

  Future<void> addProduct(Product product) async 
  {
    try 
    {
      emit(AddProductLoading());

      DocumentReference docRef = await fireStore.collection(productsConst).add
      ({
        'company_id': product.companyId,
        'distributor_id': product.distributorId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'archived': product.archived,
        'image': product.image,
      });
      
      emit(AddProductSuccess());

      product.id = docRef.id;
      getProducts();
    } catch (e) 
    {
      emit(AddProductFailure("Failed to add product: ${e.toString()}"));
    }
  }

  Future<void> deleteProduct(String productId) async 
  {
    try 
    {
      emit(DeleteProductLoading());

      await fireStore.collection(productsConst).doc(productId).delete();

      emit(DeleteProductSuccess());
      getProducts();
    } catch (e) 
    {
      emit(DeleteProductFailure("Failed to delete product: ${e.toString()}"));
    } 
  }

  Future<void> updateProduct(Product product) async 
  {
    try 
    {
      emit(UpdateProductLoading());

      await fireStore.collection(productsConst).doc(product.id).update
      ({
        'company_id': product.companyId,
        'distributor_id': product.distributorId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'archived': product.archived,
        'image': product.image,
      });

      emit(UpdateProductSuccess());

      getProducts();
    } catch (e) 
    {
      emit(UpdateProductFailure("Failed to update product: ${e.toString()}"));
    }
  }

  void archiveProduct(Product product, BuildContext context) 
  {
    Product newProduct = Product
    (
      id: product.id,
      name: product.name, 
      description: product.description, 
      price: product.price,
      companyId: product.companyId,
      archived: product.archived? false : true,
    );
    updateProduct(newProduct).then((value) 
    { 
      if(product.archived) 
      {
        ShowSnackBar(context, 'تم إلغاء أرشفة المنتج');
        getArchivedProducts();
      } else 
      {
        ShowSnackBar(context, 'تمت أرشفة المنتج');
        getProducts();
      }
    });
  }
}
