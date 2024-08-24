import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/constants.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> 
{
  ProductsCubit() : super(ProductsInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Product> products = [];


  Future<void> getProducts() async
  {
    emit(ProductsLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(productsConst).orderBy('name').get();
      
      List<Product> products = querySnapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      emit(ProductsSuccess(products));
    } catch (e) {
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

      product.id = docRef.id;

      getProducts();
    } catch (e) {
      emit(AddProductFailure("Failed to add product: ${e.toString()}"));
    }
  }

  Future<void> deleteProduct(String productId) async 
  {
    try 
    {
      emit(DeleteProductLoading());

      await fireStore.collection('products').doc(productId).delete();

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

      await fireStore.collection('products').doc(product.id).update
      ({
        'company_id': product.companyId,
        'distributor_id': product.distributorId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'archived': product.archived,
        'image': product.image,
      });

      getProducts();
    } catch (e) 
    {
      emit(UpdateProductFailure("Failed to update product: ${e.toString()}"));
    }
  }
}
