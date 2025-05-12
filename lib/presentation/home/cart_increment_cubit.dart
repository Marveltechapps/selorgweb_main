import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(int val) => emit(state + val);

  void decrement(int val) {
    if (state > 0) emit(state - val);
  }
}
