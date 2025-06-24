import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/dynamic_category_model.dart' as dm;
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/presentation/category/category_event.dart';
import 'package:selorgweb_main/presentation/category/category_state.dart';
import 'package:selorgweb_main/utils/constant.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<GetMainCategoryDataEvent>(getMainCategoryData);
    on<GetCategoryDataEvent>(getCategoryData);
    on<GetDynamicCategoryDataEvent>(getDynamicCategoryData);
  }

  getMainCategoryData(
    GetMainCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final response = await http.get(Uri.parse(maincategoryUrl));
      if (response.statusCode == 200) {
        var mainCategories = mainCategoryFromJson(response.body);
        emit(MainCategoryLoadedState(mainCategory: mainCategories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }

  getCategoryData(
    GetCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final List<Category> categories = categoryFromJson(response.body);
        emit(CategoryLoadedState(categories: categories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }

  getDynamicCategoryData(
    GetDynamicCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final dm.DynamicCategories categories = dm.dynamicCategoriesFromJson(
          response.body,
        );
        emit(DynamicCategoryLoadedState(categories: categories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }
}
