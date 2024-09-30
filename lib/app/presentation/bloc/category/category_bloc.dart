import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory/app/data/models/category.dart';
import '../../../core/repository/category_repository.dart';

// Event
abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategory extends CategoryEvent {}

class CreateCategory extends CategoryEvent {
  final Category category;

  CreateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class EditCategory extends CategoryEvent {
  final Category category; // The category to be edited

  EditCategory(this.category);

  @override
  List<Object?> get props => [category]; // Add category to props
}

// State
abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

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
        print("Category created successfully");
        add(FetchCategory());
      } catch (e) {
        print("Error creating category: $e");
        emit(CategoryError("Failed to create category: ${e.toString()}"));
      }
    });

    on<EditCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await categoryRepository
            .updateCategory(event.category); // Update the category
        add(FetchCategory()); // Fetch the updated list of categories
      } catch (e) {
        emit(CategoryError("Failed to edit category: ${e.toString()}"));
      }
    });
  }
}
