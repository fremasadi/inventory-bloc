import 'package:bloc/bloc.dart';

import '../../../core/repository/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

// BLoC
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await categoryRepository.fetchCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError("Failed to fetch categories: ${e.toString()}"));
      }
    });

    on<CreateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await categoryRepository.createCategory(event.category);
        add(FetchCategory());
      } catch (e) {
        emit(CategoryError("Failed to create category: ${e.toString()}"));
      }
    });

    on<EditCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await categoryRepository.updateCategory(event.category);
        add(FetchCategory());
      } catch (e) {
        emit(CategoryError("Failed to edit category: ${e.toString()}"));
      }
    });
    on<SearchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories =
            await categoryRepository.searchCategories(event.query);
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError("Failed to search categories: ${e.toString()}"));
      }
    });

    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await categoryRepository.deleteCategory(event.categoryId);
        emit(CategoryDeleted("Category deleted successfully"));
      } catch (e) {
        print('Error: ${e.toString()}');
        emit(CategoryError(e.toString()));
      }
      try {
        final categories = await categoryRepository.fetchCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        print('Error: ${e.toString()}');

        emit(CategoryError(e.toString()));
      }
    });
  }
}
