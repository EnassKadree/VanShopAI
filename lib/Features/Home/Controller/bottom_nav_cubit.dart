import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> 
{
  BottomNavCubit({this.init = 2}) : super(init);  
  int init;

  void updateTab(int index) 
  {
    emit(index);
  }
}