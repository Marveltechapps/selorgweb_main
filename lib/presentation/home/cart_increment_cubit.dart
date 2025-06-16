import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/utils/constant.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(int val) => emit(val);

  void decrement(int val) {
    emit(max(state - val, 0));
  }
}

class AppBarCubit extends Cubit<String> {
  AppBarCubit() : super(location); // initial value

  void updateTitle(String newTitle) {
    emit(newTitle);
  }
}