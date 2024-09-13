import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_state.dart';

class QuantityCubit extends Cubit<int> 
{
  QuantityCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() 
  {
    if (state > 0) emit(state - 1);
  }
}