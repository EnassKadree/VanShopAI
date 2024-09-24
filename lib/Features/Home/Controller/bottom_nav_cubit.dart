
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> 
{
  BottomNavCubit({this.init = 2}) : super(init);  
  int init;

  void updateTab(int index) 
  {
    emit(index);
  }
}