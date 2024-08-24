import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/constants.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> 
{
  CategoriesCubit() : super(CategoriesInitial());

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<String> selectedCategories = [];
  List<String> categories = [];

  void toggleCategorySelection(String category, bool isSelected) 
  {
    if (isSelected) 
    {
      selectedCategories.remove(category);
    } else 
    {
      selectedCategories.add(category);
    }
    emit(CategorySelectionChanged(List.from(selectedCategories)));
  }

  Future<void> fetchCategories() async 
  {
    emit(CategoriesLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(categoriesConst).orderBy('name').get();
      categories = querySnapshot.docs.map((snapshot) 
      {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['name'] as String; 
      }).toList();
      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }


  Future<void> saveUserCategories(String type) async 
  {
    emit(SaveCategoriesLoading());
    try 
    {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) 
      {
        emit(SaveCategoriesFailure('سجل دخول ثم حاول مرة أخرى'));
        return;
      }

    await fireStore.collection(type).doc(user.uid).update
    ({
    'categories': selectedCategories,
    });
      emit(SaveCategoriesSuccess());
    } catch (e) 
    {
      emit(SaveCategoriesFailure(e.toString()));
    }
  }
}
