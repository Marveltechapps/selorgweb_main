import 'package:equatable/equatable.dart';
import 'package:selorgweb_main/model/category/dynamic_category_model.dart' as dm;
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/main_category_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class MainCategoryLoadedState extends CategoryState {
  final MainCategory mainCategory;

  const MainCategoryLoadedState({required this.mainCategory});

  @override
  List<Object> get props => [mainCategory];
}

class CategoryLoadedState extends CategoryState {
  final List<Category> categories;

  const CategoryLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryErrorState extends CategoryState {
  final String message;

  const CategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class DynamicCategoryLoadedState extends CategoryState {
  final dm.DynamicCategories categories;

  const DynamicCategoryLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}