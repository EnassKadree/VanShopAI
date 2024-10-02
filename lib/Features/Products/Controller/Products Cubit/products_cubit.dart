import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';
import 'package:vanshopai/Features/Core/Model/product.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../../Extensions/sharedprefsutils.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> 
{
  ProductsCubit() : super(ProductsInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage fireStorage = FirebaseStorage.instance;
  List<Product> products = [];
  List<Product> archivedProducts = [];

  File? selectedImage;
  bool imageChanged = false;



  Future<void> getProducts({required archived, required String sender}) async
  {
    emit(ProductsLoading());
    try 
    {
      String owner = sender == companiesConst ? 'company_id' : 'distributor_id';

      QuerySnapshot querySnapshot = await fireStore.collection(productsConst)
        .where(owner, isEqualTo: prefs.getString('userID'))
        .where('archived', isEqualTo: archived)
        .get();
      
      if(archived)
      {
        archivedProducts = querySnapshot.docs.map((doc) 
        {
          return Product.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
        }).toList();
      }
      else
      {
        products = querySnapshot.docs.map((doc) 
        {
          return Product.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
        }).toList();
      }
      emit(ProductsSuccess());
    } catch (e) 
    {
      emit(ProductsFailure(e.toString()));
    }
  }

  Future<void> addProduct(Product product, String sender) async 
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
      if(selectedImage != null)
      {
        final imageUrl = await uploadImage(selectedImage!, docRef.id);
        if (imageUrl != null) 
        {
          product.image = imageUrl;
          await fireStore.collection(productsConst).doc(product.id).update({'image': imageUrl});
          selectedImage = null;
        }
      }
      emit(AddProductSuccess());

    } catch (e) 
    {
      emit(AddProductFailure("Failed to add product: ${e.toString()}"));
    }
  }


  Future<void> updateProduct(Product product, String sender) async 
  {
    try 
    {
      emit(UpdateProductLoading());

      if(selectedImage != null && imageChanged)
      {
        if(product.image != null)
        {
          await deleteImageFromStorage(product.image!);
        }

        final imageUrl = await uploadImage(selectedImage!, product.id!);
        if (imageUrl != null) 
        {
          product.image = imageUrl;
          selectedImage = null;
        }
      }

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

    } catch (e) 
    {
      emit(UpdateProductFailure("Failed to update product: ${e.toString()}"));
    }
  }

  Future<void> deleteProduct(String productId, String sender) async 
  {
    try 
    {
      emit(DeleteProductLoading());

      DocumentSnapshot productSnapshot = await fireStore.collection(productsConst).doc(productId).get();
      String? oldImageUrl = productSnapshot['image'];
      
      if(oldImageUrl != null)
      {await deleteImageFromStorage(oldImageUrl);}
      bool archived = productSnapshot['archived'];

      await fireStore.collection(productsConst).doc(productId).delete();

      emit(DeleteProductSuccess());
      getProducts(archived: archived, sender: sender);
    } catch (e) 
    {
      emit(DeleteProductFailure("Failed to delete product: ${e.toString()}"));
    } 
  }

  Future<void> deleteImageFromStorage(String imageUrl) async 
  {
    try 
    {
      Reference storageRef = fireStorage.refFromURL(imageUrl);
      await storageRef.delete();
    } catch (e) 
    {
      throw Exception("Failed to delete image from storage: ${e.toString()}");
    }
  }

  Future<String?> uploadImage(File imageFile, String productId) async 
  {
    try 
    {
      String? userID = prefs.getString('userID');
      if(userID != null)
      {
        Reference storageRef = fireStorage.ref()
        .child('$userID/$productId');
        UploadTask uploadTask = storageRef.putFile(imageFile);

        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
    } catch (e) 
    {
      return null;
    }
    return null;
  }

  void pickImage() async 
  {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) 
    {
      selectedImage = File(pickedFile.path);
      emit(ProductImageSelected(selectedImage!)); 
    }
  }

  void archiveProduct(Product product, BuildContext context, String sender) 
  {
    Product newProduct = Product
    (
      id: product.id,
      name: product.name, 
      description: product.description, 
      price: product.price,
      companyId: product.companyId,
      distributorId: product.distributorId,
      image: product.image,
      archived: product.archived? false : true,
    );
    updateProduct(newProduct, sender).then((value) 
    { 
      if(product.archived) 
      {
        showSnackBar(context, 'تم إلغاء أرشفة المنتج');
        getProducts(archived: true, sender: sender);
        getProducts(archived: false, sender: sender);
      } else 
      {
        showSnackBar(context, 'تمت أرشفة المنتج');
        getProducts(archived: false, sender: sender);
      }
    });
  }
}
